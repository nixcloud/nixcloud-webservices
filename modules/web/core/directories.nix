{ lib, config, ... }:

{
  options.directories = import ../../core/directories/options.nix {
    inherit config lib;
    isWebServices = true;
  };
}
