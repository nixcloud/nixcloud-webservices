{
  name = "nginx";
  machine.nixcloud.reverse-proxy.enable = true;
  machine.nixcloud.reverse-proxy.extendEtcHosts = true;
  machine.nixcloud.webservices.nginx = {
    foo = {
      enable = true;
      proxyOptions = {
        domain = "example.com";
        http.mode = "on";
        https.mode = "off";
        port = 8080;
      };
      webserver.nginx = {
        extraConfig = ''
          location / {
            root /var/lib/nixcloud/webservices/nginx-foo/www/;
          }
        '';
      };
    };
  };

  testScript = ''
    $machine->waitForUnit('multi-user.target');
    $machine->waitForOpenPort(80);
    $machine->succeed('curl http://example.com | grep -qF "Nothing here yet"');
  '';
}
