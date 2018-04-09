{ config, mkUnique, mkUniqueUser, mkUniqueGroup, wsName, name
, pkgs, lib, toplevel
, ...
}@webservice:

let
  systemdUnitOptions = let
    # XXX: Try to avoid this, but for now this works well.
    reEval = (import <nixpkgs/nixos/lib/eval-config.nix> {
      modules = [];
      inherit (toplevel.config.nixpkgs) system;
    }).options.systemd;
    isUnit = x: lib.isOption x && x.type.name == "attrsOf"
             && (x.type.getSubOptions null) ? unitConfig;
    optionNames = lib.attrNames (lib.filterAttrs (lib.const isUnit) reEval);
  in lib.genAttrs optionNames (name: toplevel.options.systemd.${name});

  getSubModules = opt: let
    subModules = opt.type.getSubModules;
  in map (m: m.submodule) subModules;

  availableInstanceDependencies = [
    "after" "before" "bindsTo" "conflicts" "partOf" "requiredBy" "requires"
    "requisite" "wantedBy" "wants"
  ];

  # Allow to use for example instance.after in a systemd unit, which will
  # automatically append the unique name to every list item.
  mkInstanceDependencies = defs: let
    mkDeps = name: values: (defs.${name} or []) ++ map mkUnique values;
  in lib.optionalAttrs (defs ? instance) (lib.mapAttrs mkDeps defs.instance);

  # Add an After=instance-init.target to the services which don't have
  # instance.ignore-init set to true, so that we can make sure that instance
  # initialization services will run before everything else.
  addInstanceInit = defs: let
    needsInit = !defs.instance.ignore-init or false;
    instance = if needsInit then (defs.instance or {}) // {
      after = [ "instance-init.target" ] ++ (defs.instance.after or []);
    } else (defs.instance or {});
  in defs // { instance = removeAttrs instance [ "ignore-init" ]; };

  # User configuration attributes that have their home directory within the
  # instance's stateDir.
  instanceUsers = let
    hasHomeInStatedir = ucfg: lib.hasPrefix config.stateDir ucfg.home;
  in lib.filterAttrs (lib.const hasHomeInStatedir) config.users;

  # Create a unique name for a user or group, creating a hashed version of it
  # whenever the length exceeds 31 characters. The reason for that is that
  # glibc imposes a restriction of maximum 31 characters on user and group
  # names.
  mkUniqueUserGroup = prefix: suffix: let
    uniqueName = mkUnique suffix;
    uniqueHash = builtins.hashString "sha256" uniqueName;
    hashLen = 30 - lib.stringLength prefix;
    hashed = "${prefix}-${builtins.substring 0 hashLen uniqueHash}";
  in if builtins.stringLength uniqueName > 31 then hashed else uniqueName;

  # Check if the given string is a hashed user created by 'mkUniqueUserGroup'.
  isHashed = val: builtins.match "(user|group)-[a-f0-9]+" val != null;

in {
  imports = [ ./webserver.nix ./meta.nix ./directories.nix ../database ];

  options = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable or disable the webservice.";
    };

    webserver.variant = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "apache" "lighttpd" "nginx" "darkhttpd" ]);
      default = null;
      description = "The webserver module to use for this webservice.";
    };

    stateDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/nixcloud/webservices/${config.uniqueName}";
      readOnly = true;
      description = ''
        Base directory for the state needed for this webservice.

        Can't be changed and will be set to
        <literal>/var/lib/nixcloud/webservices/''${uniqueName}</literal> as for
        example:
        <literal>/var/lib/nixcloud/webservices/owncloud-instance1</literal>.
      '';
    };

    runtimeDir = lib.mkOption {
      type = lib.types.path;
      default = "/run/nixcloud/webservices/${config.uniqueName}";
      readOnly = true;
      description = ''
        Base directory for runtime files such as sockets for this webservice.

        Can't be changed and will be set to
        <literal>/run/nixcloud/webservices/''${uniqueName}</literal> as for
        example:
        <literal>/run/nixcloud/webservices/owncloud-instance1</literal>.
      '';
    };

    toplevel = lib.mkOption {
      # TODO: Type!
      default = {};
      internal = true;
      # TODO: Write description!
      description = "";
    };

    uniqueName = lib.mkOption {
      type = lib.types.str;
      default = "${wsName}-${name}";
      readOnly = true;
      description = ''
        Can't be changed and will be set to
        <literal>''${wsName}-''${name}</literal> as for example:
        <literal>owncloud-instance1</literal>.
      '';
    };

    users = lib.mkOption {
      default = {};
      type = let
        userOpts = getSubModules toplevel.options.users.users;
      in lib.types.attrsOf (lib.types.submodule userOpts);
      inherit (toplevel.options.users.users) example description;
    };

    groups = lib.mkOption {
      default = {};
      type = let
        groupOpts = getSubModules toplevel.options.users.groups;
      in lib.types.attrsOf (lib.types.submodule groupOpts);
      inherit (toplevel.options.users.groups) example description;
    };

    systemd = (lib.mapAttrs' (name: decl: {
      inherit name;
      value = lib.mkOption {
        default = {};
        # Real type checking is done from the top-level option.
        type = lib.types.unspecified;
        inherit (decl) description;
      };
    }) systemdUnitOptions) // lib.flip lib.genAttrs (what: lib.mkOption {
      default = [];
      # Real type checking is done from the top-level option.
      type = lib.types.unspecified;
      inherit (toplevel.options.systemd.${what}) description;
    }) [ "automounts" "mounts" ];

    tests.wanted = toplevel.options.nixcloud.tests.wanted;

    meta = toplevel.options.meta;
    assertions = toplevel.options.assertions;
  };

  config = lib.mkMerge [
    { _module.args.mkUnique = suffix:
        if lib.hasPrefix config.uniqueName suffix then suffix
        else if isHashed suffix then suffix
        else if suffix == wsName then config.uniqueName
        else "${config.uniqueName}-${suffix}";

      _module.args.mkUniqueUser = mkUniqueUserGroup "user";
      _module.args.mkUniqueGroup = mkUniqueUserGroup "group";
    }
    (lib.mkIf config.enable {
      systemd.mounts = lib.singleton {
        description = "Runtime Directory For ${config.uniqueName}";
        requiredBy = lib.singleton (mkUnique "instance-init.target");
        before = lib.singleton (mkUnique "instance-init.target");
        what = "none";
        where = config.runtimeDir;
        type = "tmpfs";
        options = "nodev,nosuid,mode=1777";
      };

      directories = let
        instance.before = [
          "webserver-init.service" "instance-init.target"
        ];

        statedir."/" = {
          permissions.defaultDirectoryMode = "0711";
          inherit instance;
        };

        mkHomeDir = name: ucfg: {
          name = let
            withoutStatedir = lib.removePrefix config.stateDir ucfg.home;
            result = lib.removePrefix "/" withoutStatedir;
          in if result == "" then "/" else result;
          value = {
            owner = lib.mkOverride 200 (mkUniqueUser name);
            group = lib.mkOverride 200 (mkUniqueGroup ucfg.group);
            create = lib.mkOverride 200 ucfg.createHome;
            inherit instance;
          };
        };
      in statedir // lib.mapAttrs' mkHomeDir instanceUsers;

      systemd.targets.instance-init = {
        description = "Instance Initialization For ${config.uniqueName}";
        wantedBy = [ "multi-user.target" ];
        after = [ "local-fs.target" ];
        instance.ignore-init = true;
      };

      toplevel = lib.mkIf config.enable {
        environment.systemPackages = lib.singleton (pkgs.buildEnv {
          name = "webservice-extra-path";
          paths = config.extraPath;
        });

        users.users = lib.mapAttrs' (name: ucfg: {
          name = mkUniqueUser name;
          value = lib.mkOverride 200 ({
            name = mkUniqueUser name;
            group = mkUniqueGroup ucfg.group;
            createHome = if instanceUsers ? ${name} then false
                         else ucfg.createHome;
          } // removeAttrs ucfg [ "name" "group" "createHome" ]);
        }) config.users;

        users.groups = lib.mapAttrs' (name: gcfg: {
          name = mkUniqueGroup name;
          value = lib.mkOverride 200 ({
            name = mkUniqueGroup name;
          } // removeAttrs gcfg [ "name" ]);
        }) config.groups;

        assertions = (lib.mapAttrsToList (uname: ucfg: {
          assertion = config.groups ? ${ucfg.group};
          message = let
            o = "nixcloud.webservices.${wsName}.${name}.users.${uname}.group";
          in "Group `${ucfg.group}' defined in `${o}' does not exist.";
        }) config.users) ++ config.assertions;

        systemd = let
          generator = name: lib.mapAttrs' (unitName: defs: {
            name = mkUnique unitName;
            value = let
              defsWithoutInst = removeAttrs defs [ "instance" ];
            in defsWithoutInst // lib.optionalAttrs (defs ? serviceConfig) {
              serviceConfig = let
                sc = defs.serviceConfig;
              in sc // lib.optionalAttrs (sc ? User) {
                User = mkUniqueUser sc.User;
              } // lib.optionalAttrs (sc ? Group) {
                Group = mkUniqueGroup sc.Group;
              };
            } // mkInstanceDependencies (addInstanceInit defs);
          }) config.systemd.${name};
          attrOpts = lib.genAttrs (lib.attrNames systemdUnitOptions) generator;
        in attrOpts // {
          inherit (config.systemd) mounts automounts;
        };
      };
    })
  ];
}
