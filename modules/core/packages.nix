{ lib, ... }:

{
  nixpkgs.overlays = lib.singleton (lib.const (pkgs: {
    inherit (import ../../pkgs { inherit pkgs; }) nixcloud;
  }));
}
