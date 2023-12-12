{
  name = "leaps";

  machine.nixcloud.reverse-proxy.enable = true;
  machine.nixcloud.reverse-proxy.extendEtcHosts = true;
  machine.nixcloud.webservices.leaps = {
    foo.enable = true;
    foo.proxyOptions.domain = "example.com";
    foo.proxyOptions.http.mode = "on";
    foo.proxyOptions.https.mode = "off";
    foo.proxyOptions.port = 8080;

    bar.enable = true;
    bar.proxyOptions.domain = "example.org";
    bar.proxyOptions.http.mode = "on";
    bar.proxyOptions.https.mode = "off";
    bar.proxyOptions.port = 8081;
  };

  testScript = ''
    machine.wait_for_unit("multi-user.target")
    machine.wait_for_open_port(80)
    machine.wait_for_open_port(8080)
    machine.wait_for_open_port(8081)
    machine.succeed("curl http://example.com/ | grep -qF leaps_logo.png")
    machine.succeed("curl http://example.org/ | grep -qF leaps_logo.png")
  '';
}
