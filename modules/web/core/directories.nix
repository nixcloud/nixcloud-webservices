{ lib, config, ... }:

let
  mkDirOption = attrs: import ../../core/directories/options.nix (attrs // {
    inherit config lib;
    isWebServices = true;
  });
in {
  # NOTE: Check modules/web/default.nix if you add another option here.
  options = lib.mapAttrs (lib.const mkDirOption) {
    directories = {
      basePath = config.stateDir;
      basePathOpt = "stateDir";
    };

    runtimeDirectories = {
      basePath = config.runtimeDir;
      basePathOpt = "runtimeDir";
    };
  };
}
