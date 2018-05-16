{ system ? builtins.currentSystem
, pkgs ? import <nixpkgs> { inherit system; }
, nixpkgs ? pkgs.path
}:

let
  callTest = import ../lib/call-test.nix { inherit system pkgs nixpkgs; };
in {
  custom-webservice = callTest ./custom-webservice.nix;
  dbshell = callTest ./dbshell.nix;
  directories = callTest ./directories.nix;
  mkunique = callTest ./mkunique.nix;
  user-allocation-uid-gid-test = callTest ./user-allocation-uid-gid-test.nix;
  version = callTest ./version.nix;
  container = callTest ./container.nix;

  # XXX: These tests should be automatically gathered by the module system!
  reverse-proxy = callTest ../modules/services/reverse-proxy/test.nix;
  email = callTest ../modules/services/email/test;
  webservices.mediawiki = callTest ../modules/web/services/mediawiki/test.nix;
  webservices.leaps = callTest ../modules/web/services/leaps/test.nix;
  webservices.static-darkhttpd = callTest
    ../modules/web/services/static-darkhttpd/test.nix;
  webservices.static-nginx = callTest
    ../modules/web/services/static-nginx/test.nix;
  webservices.apache = callTest ../modules/web/services/apache/test.nix;
  webservices.nginx  = callTest ../modules/web/services/nginx/test.nix;
}
