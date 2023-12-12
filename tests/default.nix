{ system ? builtins.currentSystem
, pkgs ? import <nixpkgs> { inherit system; }
, nixpkgs ? pkgs.path
}:

let
  callTest = import ../lib/call-test.nix { inherit system pkgs nixpkgs; };
in {
  check-test-environment = callTest ./check-test-environment.nix;                              # FIXME w
  custom-webservice = callTest ./custom-webservice.nix;                                        # FIXME w
  dbshell = callTest ./dbshell.nix;                                                            # FIXME w
  directories = callTest ./directories.nix;                                                    # FIXME broken
  ip2unix = callTest ./ip2unix.nix;                                                            # FIXME broken
  mkunique = callTest ./mkunique.nix;                                                          # FIXME broken
  user-allocation-uid-gid-test = callTest ./user-allocation-uid-gid-test.nix;                  # FIXME broken
  version = callTest ./version.nix;                                                            # FIXME w
  container = callTest ./container.nix;                                                        # FIXME broken
  TLS = callTest ../modules/services/TLS/test.nix;                                             # FIXME broken

  # XXX: These tests should be automatically gathered by the module system!
  reverse-proxy = callTest ../modules/services/reverse-proxy/test.nix;                         # FIXME broken
  email = callTest ../modules/services/email/test;                                             # FIXME broken
  messaging.rabbitmq = callTest ../modules/web/messaging/rabbitmq/test.nix;                    # FIXME broken
  webservices.mediawiki = callTest ../modules/web/services/mediawiki/test.nix;                 # FIXME w
  webservices.mattermost = callTest ../modules/web/services/mattermost/test.nix;               # FIXME w
  webservices.hydra = callTest ../modules/web/services/hydra/test.nix;                         # FIXME broken
  webservices.leaps = callTest ../modules/web/services/leaps/test.nix;                         # FIXME w
  webservices.static-darkhttpd = callTest ../modules/web/services/static-darkhttpd/test.nix;   # FIXME w
  webservices.static-nginx = callTest ../modules/web/services/static-nginx/test.nix;           # FIXME w
  webservices.apache = callTest ../modules/web/services/apache/test.nix;                       # FIXME w
  webservices.nginx  = callTest ../modules/web/services/nginx/test.nix;                        # FIXME w
}
