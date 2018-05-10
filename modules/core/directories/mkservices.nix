{ pkgs, config, lib }:

path: cfg:

let
  inherit (import ./lib.nix { inherit lib; }) permConfToRWX;

  absPath = "/${path}";

  escPath = p: let
    unsafeChars = [ "@" ":" "\\" "[" "]" "/" "." ];
    safeChars = map (lib.const "-") unsafeChars;
  in lib.replaceStrings unsafeChars safeChars p;

  mkUnitName = prefix: p: "${prefix}-${escPath p}";
  mkServiceName = prefix: p: "${mkUnitName prefix p}.service";

  mkService = name: desc: attrs: {
    name = mkUnitName name path;
    value = {
      description = "${desc} ${absPath}";
      wantedBy = [ "multi-user.target" ];
      after = [ "local-fs.target" ];
      before = let
        otherPathUnits = map (mkServiceName "mkdir") subPaths;
      in cfg.before ++ lib.optionals (name == "mkdir") otherPathUnits;
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      } // (attrs.serviceConfig or {});
    } // removeAttrs attrs [ "serviceConfig" ];
  };

  mkCreateService = { name, desc, ... }@attrs: {
    name = mkUnitName name path;
    value = {
      description = "${desc} ${absPath}";
      serviceConfig = {
        Type = "oneshot";
      } // (attrs.serviceConfig or {});
    } // removeAttrs attrs [ "serviceConfig" "name" "desc" ];
  };

  mkCmd = lib.concatMapStringsSep " " lib.escapeShellArg;

  mkACL = isDir: let
    mask = with cfg.permissions; if isDir then dirMask else fileMask;
    getPerms = cfgattr: let
      realAttr = if isDir then cfgattr else cfgattr.filePerms;
    in permConfToRWX isDir realAttr;
    mkUserGroupPerm = flag: name: perms: "${flag}:${name}:${getPerms perms}";
    userPerms = lib.mapAttrsToList (mkUserGroupPerm "u") cfg.users;
    groupPerms = lib.mapAttrsToList (mkUserGroupPerm "g") cfg.groups;

    perms = if cfg.permissions.enableACLs then [
      "u::${getPerms cfg.permissions.owner}"
      "u:${cfg.owner}:${getPerms cfg.permissions.owner}"
    ] ++ userPerms ++ [
      "g::${getPerms cfg.permissions.group}"
      "g:${cfg.group}:${getPerms cfg.permissions.group}"
    ] ++ groupPerms ++ [
      "o::${getPerms cfg.permissions.others}"
      "m::${permConfToRWX isDir mask}"
    ] else [
      "u::${getPerms cfg.permissions.owner}"
      "g::${getPerms cfg.permissions.group}"
      "o::${getPerms cfg.permissions.others}"
    ];

    assertValidUnixPerms = x: let
      assertUserGroups = what: attrs: passthru: let
        csv = lib.concatMapStringsSep ", " (n: "'${n}'") (lib.attrNames attrs);
        msg = "Directory '${absPath}' has extra ${what} (${csv}) set, but"
            + " 'enableACLs' is set to false.";
      in if attrs == {} then passthru else throw msg;

      assertUsers = assertUserGroups "users" cfg.users;
      assertGroups = assertUserGroups "groups" cfg.groups;

    in if cfg.permissions.enableACLs then x else assertUsers (assertGroups x);

    defPerms = lib.optionals isDir (map (p: "d:${p}") perms);
    finalPerms = lib.optionals cfg.permissions.enableACLs defPerms ++ perms;

  in assertValidUnixPerms (lib.concatStringsSep "," finalPerms);

  subPaths = let
    allPaths = lib.attrNames config.nixcloud.directories;
    isSubPath = p: p != path && lib.hasPrefix path p;
  in lib.filter isSubPath allPaths;

  mkdirCmd = "${pkgs.coreutils}/bin/mkdir";
  chownCmd = "${pkgs.coreutils}/bin/chown";
  setfaclCmd = "${pkgs.acl}/bin/setfacl";
  findCmd = "${pkgs.findutils}/bin/find";

  # Permission setting helper for find -exec.
  setpermCmd = pkgs.writeScript "setperm.sh" ''
    #!${pkgs.stdenv.shell} -e
    acl="$1"; shift
    usr="$1"; shift
    grp="$1"; shift
    ${chownCmd} "$usr:$grp" "$@"
    ${setfaclCmd} -b -m "$acl" "$@"
  '';

  # This is needed because "mkdir -p" by itself doesn't allow us to specify the
  # mode for the parent directories. The latter is determined by the umask but
  # we can't use setuid/setgid/stick bits via the umask.
  #
  # So we mkdir each component with the mode from defaultDirectoryMode and
  # use mode 0000 for the last component in order to prevent privilege
  # escalation vulnerabilities.
  makedirsCmd = pkgs.writeScript "makedirs.sh" ''
    #!${pkgs.stdenv.shell} -e
    dirmode="$1"; shift

    makedirs() {
      local initial="$1"
      local path="$2"
      local segment="''${path%/*}"

      if [ -n "$segment" ]; then
        makedirs 0 "$segment"
      fi

      if [ "$initial" -eq 1 ]; then
        ${mkdirCmd} -p -m 0000 "$path"
      else
        ${mkdirCmd} -p -m "$dirmode" "$path"
      fi
    }

    while [ -n "$1" ]; do
      if [ "''${1:0:1}" != / ]; then
        echo "FATAL: Path $1 is not absolute." >&2
        exit 1
      fi
      makedirs 1 "$1"
      shift
    done
  '';

  inherit (cfg.permissions) defaultDirectoryMode;
  mkDirectory = mkCmd [ makedirsCmd defaultDirectoryMode absPath ];
  setPerms = mkCmd [ setpermCmd (mkACL true) cfg.owner cfg.group absPath ];

  createTarget = {
    name = mkUnitName "mkdir" path;
    value.description = "Create Directory ${absPath}";
    value.unitConfig.ConditionPathExists = "!${absPath}";
    value.wantedBy = [ "multi-user.target" ];
  };

  onPostCreate = lib.optional (cfg.postCreate != "");
  onPostCreateAsRoot = lib.optional (cfg.postCreateAsRoot != "");

  createService = mkService "mkdir" "Create Directory" {
    script = (lib.concatStringsSep "\n" [ mkDirectory setPerms ]) + "\n";
    postStart = let
      triggers = onPostCreate (mkServiceName "post-create" path)
              ++ onPostCreateAsRoot (mkServiceName "post-create-as-root" path);
      mkTrigger = unit: mkCmd [ "systemctl" "--wait" "start" unit ];
    in (lib.concatMapStringsSep "\n" mkTrigger triggers) + "\n";
    unitConfig.ConditionPathExists = "!${absPath}";
  };

  postCreateService = mkCreateService {
    name = "post-create";
    desc = "Run postCreate Commands on";
    script = cfg.postCreate;
    serviceConfig.User = cfg.owner;
    serviceConfig.Group = cfg.group;
    serviceConfig.WorkingDirectory = absPath;
  };

  postCreateAsRootService = mkCreateService {
    name = "post-create-as-root";
    desc = "Run postCreateAsRoot Commands on";
    script = cfg.postCreateAsRoot;
    serviceConfig.WorkingDirectory = absPath;
  };

  createServices = lib.singleton createService
                ++ onPostCreate postCreateService
                ++ onPostCreateAsRoot postCreateAsRootService;

  fixupService = mkService "fixup" "Fixup Permissions for Directory" {
    serviceConfig.ExecStart = let
      mkExclude = p: [ "(" "-path" "/${p}" "-prune" ")" "-o" ];
      # All the paths that are subdirectories of the current directory.
      excludes = lib.concatMap mkExclude subPaths;
      findSetPerm = t: acl: [
        "(" "-type" t "-exec" setpermCmd acl cfg.owner cfg.group "{}" "+" ")"
      ];
      permsDir = findSetPerm "d" (mkACL true);
      permsFile = findSetPerm "f" (mkACL false);
      perms = permsDir ++ [ "-o" ] ++ permsFile;
    in mkCmd ([ findCmd absPath ] ++ excludes ++ perms);
    unitConfig.ConditionPathExists = "${absPath}";
  };

in lib.singleton fixupService ++ lib.optionals cfg.create createServices
