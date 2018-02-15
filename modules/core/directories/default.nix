{ pkgs, lib, config, ... }:

{
  options.nixcloud.directories = import ./options.nix { inherit config lib; };

  config = lib.mkIf (config.nixcloud.directories != {}) {
    systemd.services = let
      serviceList = lib.mapAttrsToList (import ./mkservices.nix {
        inherit pkgs lib config;
      }) config.nixcloud.directories;
    in lib.listToAttrs (lib.concatLists serviceList);
  };
}
