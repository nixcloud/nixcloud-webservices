{
  name = "mediawiki";

  machine.nixcloud.reverse-proxy.enable = true;
  machine.nixcloud.reverse-proxy.extendEtcHosts = true;
  machine.nixcloud.webservices.mediawiki = {
    foo.enable = true;
    foo.defaultDatabaseType = "postgresql";
    foo.proxyOptions.domain = "example.com";
    foo.proxyOptions.http.mode = "on";
    foo.proxyOptions.https.mode = "off";
    foo.proxyOptions.port = 8080;

    bar.enable = true;
    bar.defaultDatabaseType = "mysql";
    bar.proxyOptions.domain = "example.org";
    bar.proxyOptions.http.mode = "on";
    bar.proxyOptions.https.mode = "off";
    bar.proxyOptions.port = 8081;
  };

  testScript = let
    searchFor = "<title>Main Page - MediaWiki</title>";
  in ''
    $machine->waitForUnit('multi-user.target');
    $machine->waitForOpenPort(80);
    $machine->waitForOpenPort(8080);
    $machine->waitForOpenPort(8081);
    $machine->succeed('curl -L http://example.com/ | grep -qF "${searchFor}"');
    $machine->succeed('curl -L http://example.org/ | grep -qF "${searchFor}"');
  '';
}
