{ pkgs, ... }:

with pkgs.lib;

let
  commonConfig = <nixpkgs/nixos/tests/common/letsencrypt/common.nix>;
  snakeoil-certs = import (<nixpkgs/nixos/tests/common/letsencrypt/snakeoil-certs.nix>);
in rec {
  name = "nixcloud.TLS";

  nodes = rec {
    letsencrypt =  "${<nixpkgs>}/nixos/tests/common/letsencrypt";

    webserver = { config, pkgs, nodes, ... }: {
      imports = [ commonConfig ];

      systemd.services."nixcloud.reload-test" = {
        description   = "nixcloud.reload-test.service";

        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          Type="oneshot";
          RemainAfterExit="yes";
          ExecStart = ''
            ${pkgs.coreutils}/bin/mkdir -p /started1
          '';
          ExecReload = ''
            ${pkgs.coreutils}/bin/mkdir -p /reloaded1
          '';
        };
      };

      systemd.services."nixcloud.restart-test" = {
        description   = "nixcloud.restart-test.service";

        serviceConfig = {
          Type="oneshot";
          RemainAfterExit="yes";
          ExecStart = ''
            ${pkgs.coreutils}/bin/mkdir -p /restarted2
          '';
        };
      };

      systemd.services."nixcloud.permCheckSelfsigned" = {
        serviceConfig = {
          User = "nixcloud-permCheck";
          Type="oneshot";
          RemainAfterExit="yes";
        };

        # if the user "nixcloud-permCheck" has access to the cert/key this exits with code 0
        script = ''
          ${pkgs.coreutils}/bin/cat ${config.nixcloud.TLS.certs."selfsigned.de".tls_certificate} > /dev/null
          ${pkgs.coreutils}/bin/cat ${config.nixcloud.TLS.certs."selfsigned.de".tls_certificate_key} > /dev/null
        '';
      };

      systemd.services."nixcloud.permCheckUsersupplied" = {
        serviceConfig = {
          User = "nixcloud-permCheck";
          Type="oneshot";
          RemainAfterExit="yes";
        };

        # if the user "nixcloud-permCheck" has access to the cert/key this exits with code 0
        script = ''
          ${pkgs.coreutils}/bin/cat ${config.nixcloud.TLS.certs."usersupplied.me".tls_certificate} > /dev/null
          ${pkgs.coreutils}/bin/cat ${config.nixcloud.TLS.certs."usersupplied.me".tls_certificate_key} > /dev/null
        '';
      };

      systemd.services."nixcloud.permCheckACMEPreliminary" = {
        serviceConfig = {
          User = "nixcloud-permCheck";
          Type="oneshot";
          RemainAfterExit="yes";
        };

        # if the user "nixcloud-permCheck" has access to the cert/key this exits with code 0
        script = ''
          ${pkgs.coreutils}/bin/cat ${config.nixcloud.TLS.certs."acmeSuppliedPreliminary.com".tls_certificate} > /dev/null
          ${pkgs.coreutils}/bin/cat ${config.nixcloud.TLS.certs."acmeSuppliedPreliminary.com".tls_certificate_key} > /dev/null
        '';
      };

      systemd.services."nixcloud.permCheckACMEsupplied" = {
        serviceConfig = {
          User = "nixcloud-permCheck";
          Type="oneshot";
          RemainAfterExit="yes";
        };

        # if the user "nixcloud-permCheck" has access to the cert/key this exits with code 0
        script = ''
          ${pkgs.coreutils}/bin/cat ${config.nixcloud.TLS.certs."validacmecert.com".tls_certificate} > /dev/null
          ${pkgs.coreutils}/bin/cat ${config.nixcloud.TLS.certs."validacmecert.com".tls_certificate_key} > /dev/null
        '';
      };

      systemd.services."nixcloud.permCheckMustFail" = {
        serviceConfig = {
          User = "nixcloud-permCheck";
          Type="oneshot";
          RemainAfterExit="yes";
        };

        # if the user "nixcloud-permCheck" has access to the cert/key this exits with code 0
        # in this case he has no access and this should exit with a fail
        script = ''
          ${pkgs.coreutils}/bin/cat ${config.nixcloud.TLS.certs."reload.it".tls_certificate} > /dev/null
          ${pkgs.coreutils}/bin/cat ${config.nixcloud.TLS.certs."reload.it".tls_certificate_key} > /dev/null
        '';
      };

      users.groups."nixcloud-permCheck" = {
        members = [ "nixcloud-permCheck" ];
      };
      users.users = {
        "nixcloud-permCheck" = {};
      };

      # mkForce is required as since call-test.nix generally disables nixcloud.TLS/ACME activity
      # but here we want to test it explicitly so we override the override with mkForce!
      nixcloud.TLS = mkForce {
        certs = {
          "selfsigned.de" = {
            mode = "selfsigned";
            users = [ "nixcloud-permCheck" ];
          };
          "acmeSuppliedPreliminary.com" = {
            mode = "ACME";
            acmeApiEndpoint = "https://doesnotexistandweknowit";
            users = [ "nixcloud-permCheck" ];
          };
          "validacmecert.com" = {
            mode = "ACME";
            # FIXME aszlig: our default is the v02 endpoint but boulder in nixpkgs can't do that at the moment
            acmeApiEndpoint = "https://acme-v02.api.letsencrypt.org/directory";
            users = [ "nixcloud-permCheck" ];
          };
          "reload.it" = {
            mode = "ACME";
            reload = [ "nixcloud.reload-restart-test.service" ];
          };
          "restart.it" = {
            mode = "ACME";
            restart = [ "nixcloud.reload-restart-test.service" ];
          };
          "usersupplied.me" = {
            mode = {
              tls_certificate=snakeoil-certs.ca.cert;
              tls_certificate_key=snakeoil-certs.ca.key;
            };
            users = [ "nixcloud-permCheck" ];
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

      nixcloud.webservices.apache.wp3 = {
        enable = true;

        proxyOptions = {
          domain = "acmeSuppliedPreliminary.com";
          port = 8082;
        };
        webserver.apache = {
          enablePHP = true;
          extraConfig = ''
            DocumentRoot "/var/lib/nixcloud/webservices/apache-wp3/www/"
            <Directory "/var/lib/nixcloud/webservices/apache-wp3/www/">
              DirectoryIndex index.html
              Options FollowSymLinks
              AllowOverride All
              Require all granted
            </Directory>
          '';
        };
      };
      nixcloud.webservices.apache.wp4 = {
        enable = true;

        proxyOptions = {
          domain = "usersupplied.me";
          port = 8083;
        };
        webserver.apache = {
          enablePHP = true;
          extraConfig = ''
            DocumentRoot "/var/lib/nixcloud/webservices/apache-wp4/www/"
            <Directory "/var/lib/nixcloud/webservices/apache-wp4/www/">
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
        ${nodes.webserver.config.networking.primaryIPAddress} acmeSuppliedPreliminary.com
        ${nodes.webserver.config.networking.primaryIPAddress} usersupplied.me
      '';
    };
  };

  testScript = ''
    $letsencrypt->waitForUnit("default.target");
    $webserver->waitForUnit("default.target");
    $client->waitForUnit("default.target");

    $letsencrypt->waitForUnit("boulder.service");
    $webserver->waitForUnit("nixcloud.TLS-certificates.target");

    # if the nixcloud.reverse-proxy doesn't make it, we don't need to go on
    $webserver->waitForUnit("nixcloud.reverse-proxy.service");

    #$webserver->succeed("journalctl -xe  >&2");
    # test if selfsigned certificates are working
    $client->succeed('${pkgs.curl}/bin/curl -k https://selfsigned.de | grep -qF "Nothing here yet?"');
    # test if acmeSuppliedPreliminary set valid fallback certificates
    $client->succeed('${pkgs.curl}/bin/curl -k https://acmeSuppliedPreliminary.com | grep -qF  "Nothing here yet?"');
    # test if passed in cert/key works with our abstraction
    $client->succeed('${pkgs.curl}/bin/curl -k https://usersupplied.me | grep -qF  "Nothing here yet?"');

    # FIXME qknight: left both commands here for manual checks but both should be triggered by nixcloud.TLS on ACME updates
    #$webserver->succeed("systemctl reload nixcloud.reload-test.service >&2");
    #$webserver->succeed("systemctl restart nixcloud.restart-test.service >&2");
    # check if the restart/reload from ACME started
    #  -> later we use this with reload and restart
    #$webserver->succeed("ls -lathr / >&2");
    #$webserver->succeed("exit 1 >&2");

    # test if ACME supplied certificate is downloaded and used
    # FIXME: @aszlig implement that below
    #$client->succeed('${pkgs.curl}/bin/curl https://validacmecert.com | grep -qF "Nothing here yet?"');

    # checking permissions (selfsigned)
    $webserver->succeed("systemctl start nixcloud.permCheckSelfsigned");

    # checking permissions (usersupplied)
    $webserver->succeed("systemctl start nixcloud.permCheckUsersupplied");

    # checking permissions (Preliminary ACME)
    $webserver->succeed("systemctl start nixcloud.permCheckACMEPreliminary");

    # checking permissions (ACME)
    $webserver->succeed("systemctl start nixcloud.permCheckACMEsupplied");

    # checking if user can also see certs without valid permissions
    $webserver->fail("systemctl start nixcloud.permCheckMustFail");
  '';
}
