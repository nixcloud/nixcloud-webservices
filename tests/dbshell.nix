{
  name = "dbshell";

  machine = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.mariadb ];
    nixcloud.reverse-proxy.enable = true;
    nixcloud.reverse-proxy.extendEtcHosts = true;
    nixcloud.webservices.mediawiki = {
      foo.enable = true;
      foo.defaultDatabaseType = "postgresql";
      foo.proxyOptions.TLS = "none";
      foo.proxyOptions.domain = "example.com";
      foo.proxyOptions.http.mode = "on";
      foo.proxyOptions.https.mode = "off";
      foo.proxyOptions.port = 8080;

      bar.enable = true;
      bar.defaultDatabaseType = "mysql";
      bar.proxyOptions.TLS = "none";
      bar.proxyOptions.domain = "example.org";
      bar.proxyOptions.http.mode = "on";
      bar.proxyOptions.https.mode = "off";
      bar.proxyOptions.port = 8081;
    };
  };

  testScript = ''
    $machine->waitForUnit('multi-user.target');

    subtest "shell works with explicit web service name", sub {
      $machine->succeed(
        'echo "\\dt" | nixcloud-dbshell mediawiki-foo mediawiki'.
        ' | grep -q interwiki'
      );

      $machine->succeed(
        'echo SHOW TABLES | nixcloud-dbshell mediawiki-bar mediawiki'.
        ' | grep -q interwiki'
      );
    };

    subtest "shell works without explicit web service name", sub {
      $machine->succeed(
        'cd /var/lib/nixcloud/webservices/mediawiki-bar/mysql'.
        ' && echo SHOW TABLES | nixcloud-dbshell mediawiki'.
        ' | grep -q interwiki'
      );
    };
  '';
}
