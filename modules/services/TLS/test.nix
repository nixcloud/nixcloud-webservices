{ pkgs, ... }:

let
  commonConfig = "${<nixpkgs>}/nixos/tests/common/letsencrypt/common.nix";
in {
  name = "nixcloud.TLS";

  nodes = rec {
    letsencrypt =  "${<nixpkgs>}/nixos/tests/common/letsencrypt";

    webserver = { config, pkgs, nodes, ... }: {
      imports = [ commonConfig ];
      networking = {
        firewall.allowedTCPPorts = [ 80 443 ];

        extraHosts = ''
          ${nodes.letsencrypt.config.networking.primaryIPAddress} boulder
        '';
      };

      # lib.mkForce is required as since call-test.nix generally disables nixcloud.TLS/ACME activity
      # but here we want to test it explicitly so we override the override with mkForce!
      nixcloud.TLS = pkgs.lib.mkForce {
        certs = {
          "selfsigned.de" = {
            mode = "selfsigned";
          };
          "validacmecert.com" = {
            mode = "ACME";
            acmeApiEndpoint = "https://boulder:4430/directory";
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

      nixcloud.webservices.apache.wp2 = {
        enable = true;

        proxyOptions = {
          domain = "validacmecert.com";
          port = 8081;
        };
        webserver.apache = {
          enablePHP = true;
          extraConfig = ''
            DocumentRoot "/var/lib/nixcloud/webservices/apache-wp2/www/"
            <Directory "/var/lib/nixcloud/webservices/apache-wp2/www/">
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
        ${nodes.webserver.config.networking.primaryIPAddress} validacmecert.com
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
    $webserver->succeed("journalctl -xe  >&2");
    $client->waitForUnit("default.target");
    # test if selfsigned certificates are working
    $client->succeed('curl -k https://selfsigned.de | grep -qF "Nothing here yet?"');
    # test if ACME supplied certificate is downloaded and used
    $client->succeed('curl https://validacmecert.com | grep -qF "Nothing here yet?"');
  '';
}



#
# letsencrypt# Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode      PID/Program name
# letsencrypt# tcp        0      0 192.168.1.2:53          0.0.0.0:*               LISTEN      53         16849      698/named
# letsencrypt# tcp        0      0 10.0.2.15:53            0.0.0.0:*               LISTEN      53         16847      698/named
# letsencrypt# tcp        0      0 127.0.0.1:53            0.0.0.0:*               LISTEN      53         16845      698/named
# letsencrypt# tcp        0      0 127.0.0.1:953           0.0.0.0:*               LISTEN      53         16881      698/named
# letsencrypt# tcp        0      0 127.0.0.1:5657          0.0.0.0:*               LISTEN      0          16164      617/pkcs11-daemon
# letsencrypt# tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN      0          16866      716/nginx: master p
# letsencrypt# tcp6       0      0 :::4500                 :::*                    LISTEN      0          18973      889/ct-test-srv
# letsencrypt# tcp6       0      0 :::4501                 :::*                    LISTEN      0          18975      889/ct-test-srv
# letsencrypt# tcp6       0      0 :::53                   :::*                    LISTEN      53         16780      698/named
# letsencrypt# tcp6       0      0 :::443                  :::*                    LISTEN      0          16867      716/nginx: master p
# letsencrypt# tcp6       0      0 :::8000                 :::*                    LISTEN      0          18871      899/boulder-wfe
# letsencrypt# tcp6       0      0 :::8001                 :::*                    LISTEN      0          19082      895/boulder-ca
# letsencrypt# tcp6       0      0 :::4002                 :::*                    LISTEN      0          18995      888/ocsp-responder
# letsencrypt# tcp6       0      0 :::8002                 :::*                    LISTEN      0          18838      891/boulder-ra
# letsencrypt# tcp6       0      0 :::9091                 :::*                    LISTEN      0          18786      893/boulder-publish
# letsencrypt# tcp6       0      0 :::8003                 :::*                    LISTEN      0          18759      890/boulder-sa
# letsencrypt# tcp6       0      0 :::9092                 :::*                    LISTEN      0          19149      916/boulder-va
# letsencrypt# tcp6       0      0 :::8004                 :::*                    LISTEN      0          19106      916/boulder-va
# letsencrypt# tcp6       0      0 :::9380                 :::*                    LISTEN      0          18813      897/mail-test-srv
# letsencrypt# tcp6       0      0 :::9093                 :::*                    LISTEN      0          19158      895/boulder-ca
# letsencrypt# tcp6       0      0 :::9381                 :::*                    LISTEN      0          18820      897/mail-test-srv
# letsencrypt# tcp6       0      0 :::8005                 :::*                    LISTEN      0          18752      888/ocsp-responder
# letsencrypt# tcp6       0      0 :::8006                 :::*                    LISTEN      0          19201      947/ocsp-updater
# letsencrypt# tcp6       0      0 :::9094                 :::*                    LISTEN      0          19190      891/boulder-ra
# letsencrypt# tcp6       0      0 :::9095                 :::*                    LISTEN      0          18965      890/boulder-sa
# letsencrypt# tcp6       0      0 :::9096                 :::*                    LISTEN      0          19159      895/boulder-ca
# letsencrypt# tcp6       0      0 :::8009                 :::*                    LISTEN      0          18787      893/boulder-publish
# letsencrypt# tcp6       0      0 :::3306                 :::*                    LISTEN      84         17075      777/mysqld
# letsencrypt# tcp6       0      0 :::4430                 :::*                    LISTEN      0          19083      899/boulder-wfe
# letsencrypt# tcp6       0      0 :::80                   :::*                    LISTEN      0          19077      899/boulder-wfe
# letsencrypt# tcp6       0      0 :::6000                 :::*                    LISTEN      0          17961      865/gsb-test-srv
# letsencrypt# udp        0      0 192.168.1.2:53          0.0.0.0:*                           53         16848      698/named
# letsencrypt# udp        0      0 10.0.2.15:53            0.0.0.0:*                           53         16846      698/named
# letsencrypt# udp        0      0 127.0.0.1:53            0.0.0.0:*                           53         16844      698/named
# letsencrypt# udp        0      0 0.0.0.0:68              0.0.0.0:*                           0          16185      667/dhcpcd
# letsencrypt# udp6       0      0 :::53                   :::*
