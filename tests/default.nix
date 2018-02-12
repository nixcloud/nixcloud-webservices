{ system ? builtins.currentSystem, pkgs ? import <nixpkgs> {} }:

let
  callTest = import ../lib/call-test.nix { inherit system pkgs; };
in {
  custom-webservice = callTest ./custom-webservice.nix;
  directories = callTest ./directories.nix;
  user-allocation-uid-gid-test = callTest ./user-allocation-uid-gid-test.nix;

  # XXX: These tests should be automatically gathered by the module system!
  reverse-proxy = callTest ../modules/services/reverse-proxy/test.nix;
  webservices.mediawiki = callTest ../modules/web/services/mediawiki/test.nix;
  webservices.leaps = callTest ../modules/web/services/leaps/test.nix;
}
