let
  customWebService = let
    submodule = { pkgs, ... }: {
      webserver.variant = "lighttpd";
      webserver.lighttpd.extraConfig = ''
        server.document-root = "${pkgs.runCommand "docroot" {} ''
          mkdir "$out"
          echo hello world > "$out/index.html"
        ''}"
      '';
    };
  in import ../lib/make-webservice.nix "custom-foobar" submodule;

in {
  name = "custom-webservice";

  machine = { lib, ... }: {
    imports = lib.singleton customWebService;

    nixcloud.reverse-proxy.enable = true;
    nixcloud.reverse-proxy.extendEtcHosts = true;

    nixcloud.webservices.custom-foobar = {
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
  };

  testScript = ''
    $machine->waitForUnit('multi-user.target');
    $machine->succeed('curl http://example.com/ | grep -qF "hello world"');
    $machine->succeed('curl http://example.org/ | grep -qF "hello world"');
  '';
}

