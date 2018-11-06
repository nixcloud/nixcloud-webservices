{ pkgs, ... }:

let
  commonConfig = "${<nixpkgs>}/nixos/tests/common/letsencrypt/common.nix";
in {
  name = "TLS";

  nodes = rec {
    letsencrypt =  "${<nixpkgs>}/nixos/tests/common/letsencrypt";

    webserver = { config, pkgs, ... }: {
      imports = [ commonConfig ];
      networking.firewall.allowedTCPPorts = [ 80 443 ];

      # lib.mkForce is required as since call-test.nix generally disables nixcloud.TLS/ACME activity
      # but here we want to test it explicitly so we override the override with mkForce!
      nixcloud.TLS = pkgs.lib.mkForce {
        certs = {
          "selfsigned.de" = {
            mode = "selfsigned";
          };
          "valid.acme" = {
            mode = "ACME";
          };
        };
      };

      nixcloud.reverse-proxy = {
        enable = true;
      };

      nixcloud.webservices.apache.wp1 = {
        enable = true;

        proxyOptions = {
          domain = "selfsigned.de";
          port = 8080;
        };
        webserver.apache = {
          enablePHP = true;
          extraConfig = ''
            DocumentRoot "/var/lib/nixcloud/webservices/apache-wp1/www/"
            <Directory "/var/lib/nixcloud/webservices/apache-wp1/www/">
              DirectoryIndex index.html
              Options FollowSymLinks
              AllowOverride All
              Require all granted
            </Directory>
          '';
        };
      };
    };
    client = { config, pkgs, nodes,... }: {
      imports = [ commonConfig ];
      networking.extraHosts = ''
        ${nodes.webserver.config.networking.primaryIPAddress} selfsigned.de
      '';
    };
  };

# nixcloud.TLS-selfsigned.target
# nixcloud.TLS-usersupplied.target
# nixcloud.TLS-acmeSuppliedPreliminary-certificates.target
# nixcloud.TLS-acmeSupplied-certificates.target

  testScript = ''
    $letsencrypt->waitForUnit("default.target");
    $letsencrypt->waitForUnit("boulder.service");
    $webserver->waitForUnit("default.target");
    $webserver->waitForUnit("nixcloud.TLS-certificates.target");
    $client->waitForUnit("default.target");
    # test if selfsigned certificates are working
    $client->succeed('curl -k https://selfsigned.de | grep -qF "Nothing here yet?"');
  '';
}
