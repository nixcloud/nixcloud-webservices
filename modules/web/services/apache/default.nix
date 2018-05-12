{ config, options, lib, mkUniqueUser, mkUniqueGroup, ... }:
{
  config = lib.mkMerge [
    {
       directories.www = {
        owner = mkUniqueUser config.webserver.user;
        group = mkUniqueGroup config.webserver.group;
        instance.before = [ "webserver-init.service" "instance-init.target" ];
        postCreate = ''
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

          cat > index.php <<EOF
          <!DOCTYPE html>
          <html>
            <head>
              <meta charset="UTF-8">
              <title>Nothing here yet?</title>
            </head>
            <body>
              <h1><?php echo '<p>HelloWorld from php</p>'; ?> </h1>
              <p>You can place files into
                 <code>${config.stateDir}/www</code>.</p>
            </body>
          </html>
          EOF          
        '';
      };
    }
    {
      webserver.variant = "apache";
      tests.wanted = [ ./test.nix ];
    }
  ];

  meta = {
    description = "Declarative apache backend implementation for hacking";
    maintainers = with lib.maintainers; [ qknight ];
    license = lib.licenses.bsd2;
    homepage = https://github.com/nixcloud/nixcloud-webservices;
  };
}
