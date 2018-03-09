{ config, lib, ... }:

{
  options = {
    root = lib.mkOption {
      type = lib.types.path;
      default = config.stateDir;
      example = /var/www/whatever;
      description = "The directory where the static webserver looks for documents to serve.";
    };
  };

  config = rec {
    webserver.variant = "darkhttpd";
    webserver.darkhttpd.root = config.root;
    tests.wanted = [ ./test.nix ];
  };

  meta = {
    description = "Using darkhttpd for static file serving (no CGI)";
    maintainers = with lib.maintainers; [ qknight ];
    license = lib.licenses.bsd2;
    homepage = https://github.com/nixcloud/nixcloud-webservices;
  };
}
