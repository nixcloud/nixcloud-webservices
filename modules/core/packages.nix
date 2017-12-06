{ lib, pkgs, ... }:
with pkgs;

{
  nixpkgs.overlays = [
    (self: super: {
      inherit (import ../../pkgs { inherit pkgs; }) nixcloud;
      #lxc = super.lxc.overrideAttrs (drv: rec {
      #  version = "2.1.1";
      #  name = "lxc-${version}";
      #  src = /etc/nixos/pkgs/lxc;
      #  patches = [  ];
      #});
    })
  ];
}
