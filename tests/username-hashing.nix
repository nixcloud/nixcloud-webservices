let
  longName = "veryveryveryveryveryverylongname";
in {
  name = "username-hashing";

  machine = {
    nixcloud.reverse-proxy.enable = true;
    nixcloud.reverse-proxy.extendEtcHosts = true;

    nixcloud.webservices.static-nginx.${longName} = {
      enable = true;
      proxyOptions.TLS = "none";
      proxyOptions.domain = "example.org";
      proxyOptions.http.mode = "on";
      proxyOptions.https.mode = "off";
      proxyOptions.port = 8080;
    };
  };

  testScript = ''
    $machine->waitForUnit('static-nginx-${longName}-nginx.service');
  '';
}
