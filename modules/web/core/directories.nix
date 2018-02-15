{ pkgs, lib, config, ... }:

let
  optionsPath = ../../core/directories/options.nix;
  mkservicesPath = ../../core/directories/mkservices.nix;

in {
  options.directories = import optionsPath {
    inherit config lib;
    isWebServices = true;
  };
}
