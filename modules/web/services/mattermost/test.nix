{
  name = "mattermost";

  machine.nixcloud.reverse-proxy.enable = true;
  machine.nixcloud.reverse-proxy.extendEtcHosts = true;
  machine.nixcloud.webservices.mattermost = {
    foo.enable = true;
    foo.proxyOptions.domain = "example.com";
    foo.proxyOptions.http.mode = "on";
    foo.proxyOptions.https.mode = "off";
    foo.proxyOptions.port = 8080;
  };

  testScript = let
    searchFor = "<title>Mattermost</title>";
  in ''
    $machine->waitForUnit('multi-user.target');
    # wait for reverse-proxy
    $machine->waitForOpenPort(80);
    # wait for the mattermost ELF (GO) binary
    $machine->waitForOpenPort(8080);
    $machine->succeed('curl -L http://example.com/ | grep -qF "${searchFor}"');
  '';
}
