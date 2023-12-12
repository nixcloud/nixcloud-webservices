{
  name = "mattermost";

  machine.nixcloud.reverse-proxy.enable = true;
  machine.nixcloud.reverse-proxy.extendEtcHosts = true;
  machine.nixcloud.webservices.mattermost.foo = {
    enable = true;
    proxyOptions = {
    domain = "example.com";
      http.mode = "on";
      https.mode = "off";
      port = 8080;
    };
  };

  testScript = let
    searchFor = "<title>Mattermost</title>";
  in ''
    machine.wait_for_unit('multi-user.target')
    # wait for reverse-proxy
    machine.wait_for_open_port(80)
    # wait for the mattermost ELF (GO) binary
    machine.wait_for_open_port(8080)
    machine.succeed('curl -L http://example.com/ | grep -qF "${searchFor}"')
  '';
}
