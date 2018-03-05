{ config, lib, pkgs, wsName, mkUnique, darkhttpd, ... }:

with lib;

{
  options = {};

  config = rec {
    webserver.variant = "darkhttpd";
    tests.wanted = [ ./test.nix ];
  };

  meta = {
    description = "Using darkhttpd for static file serving (no CGI)";
    maintainers = with maintainers; [ qknight ];
    license = lib.licenses.bsd2;
    homepage = https://github.com/nixcloud/nixcloud-webservices;
  };
}
