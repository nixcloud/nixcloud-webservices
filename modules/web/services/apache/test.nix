{
  name = "apache";
  machine.nixcloud.reverse-proxy.enable = true;
  machine.nixcloud.reverse-proxy.extendEtcHosts = true;
  machine.nixcloud.webservices.apache = {
    foo = {
      enable = true;
      proxyOptions = {
        domain = "example.com";
        http.mode = "on";
        https.mode = "off";
        port = 8080;
      };
      webserver.apache = {
        enablePHP = true;
        phpOptions = ''
          # foo's config.... 
        '';
        extraConfig = ''
          DocumentRoot "/var/lib/nixcloud/webservices/apache-foo/www/"
          <Directory "/var/lib/nixcloud/webservices/apache-foo/www/">
            Options FollowSymLinks
            AllowOverride None
            Require all granted
          </Directory>
        '';
      };
    };
  };

  testScript = ''
    $machine->waitForUnit('multi-user.target');
    $machine->waitForOpenPort(80);
    $machine->succeed('curl http://example.com/index.php | grep -qF HelloWorld');
  '';
}
