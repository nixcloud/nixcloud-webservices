{ config, lib, ... }:

{
  options = {
    root = lib.mkOption {
      type = lib.types.path;
      default = "${config.stateDir}/www";
      example = /var/www/whatever;
      description = "The directory where the static webserver looks for documents to serve.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (config.root == "${config.stateDir}/www") {
      # XXX: Make DRY with the one in static-nginx!
      directories.www.postCreate = ''
        cat > index.html <<EOF
        <!DOCTYPE html>
        <html>
          <head>
            <meta charset="UTF-8">
            <title>Nothing here yet?</title>
          </head>
          <body>
            <h1>Nothing here yet?</h1>
            <p>You can place files into
               <code>${config.stateDir}/www</code>.</p>
          </body>
        </html>
        EOF
      '';
    })
    { webserver.variant = "darkhttpd";
      webserver.darkhttpd.root = config.root;
      tests.wanted = [ ./test.nix ];
    }
  ];

  meta = {
    description = "Using darkhttpd for static file serving (no CGI)";
    maintainers = with lib.maintainers; [ qknight ];
    license = lib.licenses.bsd2;
    homepage = https://github.com/nixcloud/nixcloud-webservices;
  };
}
