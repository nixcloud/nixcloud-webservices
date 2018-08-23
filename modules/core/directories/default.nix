{ pkgs, lib, config, ... }:

{
  options.nixcloud.directories = import ./options.nix { inherit config lib; };

  config = lib.mkIf (config.nixcloud.directories != {}) {
    systemd.services = let
      serviceList = lib.mapAttrsToList (import ./mkservices.nix {
        inherit pkgs lib config;
      }) config.nixcloud.directories;
    in lib.listToAttrs (lib.concatLists serviceList);

    assertions = lib.concatLists (lib.mapAttrsToList (path: cfg: let
      optname = "nixcloud.directories.\"${path}\"";
      mkUserAssertion = where: username: {
        assertion = config.users.users ? ${username};
        message = "The user '${username}' specified in '${optname}.${where}'"
                + " does not exist.";
      };
      mkGroupAssertion = where: groupname: {
        assertion = config.users.groups ? ${groupname};
        message = "The group '${groupname}' specified in '${optname}.${where}'"
                + " does not exist.";
      };
      assertions = [
        (mkUserAssertion "owner" cfg.owner)
        (mkGroupAssertion "group" cfg.group)
      ] ++ map (mkUserAssertion "users") (lib.attrNames cfg.users)
        ++ map (mkGroupAssertion "groups") (lib.attrNames cfg.groups);
    in assertions) config.nixcloud.directories);
  };
}
