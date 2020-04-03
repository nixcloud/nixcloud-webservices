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
      rspamd = let
          version = super.rspamd.version;
        in if (lib.versionAtLeast version "1.7.3") && (lib.versionOlder version "1.8.1")
          then super.rspamd.overrideAttrs (oldAttrs: rec {
            patches = ["${./rspamd}/rspamd-${version}-local-rules.patch"];
          })
          else super.rspamd;
    })
  ];
}
