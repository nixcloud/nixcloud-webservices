{ config, lib, pkgs, wsName, mkUnique, nginx, ... }:

with lib;

{
  options = {};

  config = rec {
    webserver.variant = "nginx";
    webserver.nginx.extraConfig = ''
      index index.html;
      root ${config.stateDir}/www;
    '';
    tests.wanted = [ ./test.nix ];
  };

  meta = {
    description = "Using nginx for static file serving (no CGI)";
    maintainers = with maintainers; [ qknight ];
    license = lib.licenses.bsd2;
    homepage = https://github.com/nixcloud/nixcloud-webservices;
  };
}
