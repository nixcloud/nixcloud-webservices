{
  name = "leaps";

  machine.nixcloud.reverse-proxy.enable = true;
  machine.nixcloud.reverse-proxy.extendEtcHosts = true;
  machine.nixcloud.webservices.leaps = {
    foo.enable = true;
    foo.proxyOptions.TLS = "none";
    foo.proxyOptions.domain = "example.com";
    foo.proxyOptions.http.mode = "on";
    foo.proxyOptions.https.mode = "off";
    foo.proxyOptions.port = 8080;

    bar.enable = true;
    bar.proxyOptions.TLS = "none";
    bar.proxyOptions.domain = "example.org";
    bar.proxyOptions.http.mode = "on";
    bar.proxyOptions.https.mode = "off";
    bar.proxyOptions.port = 8081;
  };

  testScript = ''
    $machine->waitForUnit('multi-user.target');
    $machine->succeed('curl http://example.com/ | grep -qF leaps_logo.png');
    $machine->succeed('curl http://example.org/ | grep -qF leaps_logo.png');
  '';
}
