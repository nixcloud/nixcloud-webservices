{ system ? builtins.currentSystem, pkgs ? import <nixpkgs> {} }:

let
  callTest = import ../lib/call-test.nix { inherit system pkgs; };
in {
  custom-webservice = callTest ./custom-webservice.nix;
  reverse-proxy = callTest ./reverse-proxy.nix;
  leaps = callTest ./leaps.nix;
  mediawiki = callTest ./mediawiki.nix;
  user-allocation-uid-gid-test = callTest ./user-allocation-uid-gid-test.nix;
}
