{ pkgs, ... }:

let
  testAccounts = let
    inherit (pkgs) lib;
  in lib.mapAttrs (name: attrs: attrs // {
    address = "${name}@${attrs.domain}";
  }) (import ./accounts.nix);

  # These are the additional attributes we support in our test accounts, which
  # we need to remove later when generating options for the virtual users.
  extraTestAccountAttrs = [ "plainPasswd" "server" "address" ];

  mkNetworkConfig = suffix: { config, lib, ... }: {
    options._test-support = let
      mkSupportOption = default: lib.mkOption {
        type = lib.types.str;
        inherit default;
        internal = true;
        description = "Test support option";
      };
    in {
      v4addr = mkSupportOption "192.168.0.${toString suffix}";
      v4rev = mkSupportOption "${toString suffix}.0.168.192.in-addr.arpa";
      v6addr = mkSupportOption "abcd::${toString suffix}";
      v6rev = let
        base = lib.genList (lib.const "0") 28
            ++ [ "d" "c" "b" "a" "ip6" "arpa" ];
        singles = lib.reverseList (lib.stringToCharacters (toString suffix));
        result = singles ++ lib.drop (lib.length singles) base;
      in mkSupportOption (lib.concatStringsSep "." result);
    };

    config.networking.useDHCP = false;
    config.networking.interfaces.eth1 = {
      ipv4.addresses = lib.singleton {
        address = config._test-support.v4addr;
        prefixLength = 24;
      };
      ipv6.addresses = lib.singleton {
        address = config._test-support.v6addr;
        prefixLength = 24;
      };
    };
  };

  commonConfig = { lib, nodes, ... }: {
    networking.nameservers = lib.mkForce [
      nodes.dns.config._test-support.v4addr
      nodes.dns.config._test-support.v6addr
    ];
  };


  mkMailConfig = hostname: domains: { config, lib, ... }: {
    imports = [ commonConfig ];
    nixpkgs.overlays = lib.singleton (self: super: {
      # Make sure sa-update doesn't try to access the network:
      spamassassin = super.spamassassin.overrideAttrs (drv: {
        testRules = self.writeText "spamd-test-rules.cf" ''
          body NIXCLOUD_TEST_RULE /I am a spammer/
          score NIXCLOUD_TEST_RULE 20.0
          describe NIXCLOUD_TEST_RULE Rule for VM test
        '';

        # Our own version of sa-update which places our testRules from above so
        # that we can use it later to check whether spamd correctly identifies
        # stuff as spam.
        preFixup = (drv.preFixup or "") + ''
          make version.env
          source version.env
          rulesDir="/var/lib/spamassassin/$CPAN_VERSION"
          cat > "$out/bin/sa-update" <<EOF
          #!${self.stdenv.shell}
          export PATH="${self.coreutils}/bin"
          mkdir -p "$rulesDir"
          cat "$testRules" > "$rulesDir/updates_spamassassin_org.cf"
          EOF
        '';
      });
    });
    nixcloud.email = {
      enable = true;
      enableTLS = false;
      ipAddress = config._test-support.v4addr;
      ip6Address = config._test-support.v6addr;
      fqdn = hostname;
      inherit domains;
      # FIXME: Disabled for now because we really don't want to wait >300
      #        seconds for the test to run.
      enableGreylisting = false;
      webmail.enable = true;
      users = let
        isLocalUser = lib.const (attrs: lib.elem attrs.domain domains);
        localUsers = lib.filterAttrs isLocalUser testAccounts;
      in lib.mapAttrsToList (name: attrs: {
        inherit name;
      } // removeAttrs attrs extraTestAccountAttrs) localUsers;
    };
  };

in {
  name = "email";

  nodes.dns = { config, pkgs, lib, nodes, ... }: {
    imports = lib.singleton (mkNetworkConfig 1);
    networking.firewall.enable = false;
    services.bind.enable = true;
    services.bind.cacheNetworks = lib.mkForce [ "any" ];

    # XXX/FIXME: Config file injection because the values aren't escaped in the
    #            BIND module of <nixpkgs>. Let's actually directly fix this in
    #            <nixpkgs> by adding an option which allows us to set options
    #            and using something like "options { empty-zones-enable no; };"
    #            in extraConfig won't work because BIND doesn't allow
    #            redefinition of options.
    services.bind.forwarders = lib.mkForce [ "}; empty-zones-enable no; #" ];

    services.bind.zones = lib.singleton {
      name = ".";
      file = pkgs.writeText "root.zone" ''
        $TTL 3600
        . IN SOA ns.fakedns. admin.fakedns. ( 1 3h 1h 1w 1d )
        . IN NS ns.fakedns.

        ns.fakedns. IN    A ${config._test-support.v4addr}
        ns.fakedns. IN AAAA ${config._test-support.v6addr}

        mail.example.org. IN    A ${nodes.mail1.config._test-support.v4addr}
        mail.example.org. IN AAAA ${nodes.mail1.config._test-support.v6addr}

        mail.example.com. IN    A ${nodes.mail2.config._test-support.v4addr}
        mail.example.com. IN AAAA ${nodes.mail2.config._test-support.v6addr}

        mx.example.org. IN    A ${nodes.mail1.config._test-support.v4addr}
        mx.example.org. IN AAAA ${nodes.mail1.config._test-support.v6addr}

        mx.example.com. IN    A ${nodes.mail2.config._test-support.v4addr}
        mx.example.com. IN AAAA ${nodes.mail2.config._test-support.v6addr}

        example.org. IN MX 10 mx.example.org.
        example.net. IN MX 10 mx.example.org.
        example.com. IN MX 10 mx.example.com.
        catchall.example. IN MX 10 mx.example.com.

        ; Reverse PTRs, note that the client doesn't have one and also
        ; shouldn't have one to make sure the MSA picks it up even if it's a
        ; dialup connection somewhere in Siberia.
        ${config._test-support.v4rev}. IN PTR ns.fakedns.
        ${config._test-support.v6rev}. IN PTR ns.fakedns.

        ${nodes.mail1.config._test-support.v4rev}. IN PTR mx.example.org.
        ${nodes.mail1.config._test-support.v6rev}. IN PTR mx.example.org.

        ${nodes.mail2.config._test-support.v4rev}. IN PTR mx.example.com.
        ${nodes.mail2.config._test-support.v6rev}. IN PTR mx.example.com.
      '';
    };
  };

  nodes.mail1.imports = [
    (mkMailConfig "mx.example.org" [ "example.org" "example.net" ])
    (mkNetworkConfig 11)
  ];

  nodes.mail2.imports = [
    (mkMailConfig "mx.example.com" [ "example.com" "catchall.example" ])
    (mkNetworkConfig 12)
  ];

  nodes.client = { lib, pkgs, ... }: {
    imports = [ commonConfig (mkNetworkConfig 100) ];
    environment.systemPackages = lib.singleton (pkgs.runCommand "run-tests" {
      src = ./test.py;
      testAccounts = builtins.toJSON testAccounts;
      nativeBuildInputs = lib.singleton pkgs.makeWrapper;
      inherit (pkgs.python3) interpreter;
    } ''
      mkdir -p "$out/bin"
      makeWrapper "$interpreter" "$out/bin/run-tests" \
        --set TEST_ACCOUNTS "$testAccounts" \
        --add-flags "$src"
    '');
  };

  testScript = ''
    startAll;
    $dns->waitForUnit('bind.service');
    $mail1->waitForUnit('multi-user.target');
    $mail2->waitForUnit('multi-user.target');
    $client->waitForUnit('multi-user.target');
    $client->succeed('run-tests >&2');
    # wait for reverse-proxy
    $mail1->waitForOpenPort(80);
    $mail2->waitForOpenPort(80);
    $mail1->waitForOpenPort(8993);
    $mail2->waitForOpenPort(8993);
    $mail1->succeed('curl -L http://mail.example.org/ | grep -qF "<title>Roundcube"');
    # Check spam learning
    $mail2->waitUntilSucceeds("journalctl -u dovecot2 | grep learn-spam.sh >&2");
    $mail2->succeed('journalctl -u rspamd | grep "csession; rspamd_controller_learn_fin_task: </run/rspamd/worker-controller.sock> learned message as spam" >&2');
    $mail2->waitUntilSucceeds("journalctl -u dovecot2 | grep learn-ham.sh >&2");
    $mail2->succeed('journalctl -u rspamd | grep "csession; rspamd_controller_learn_fin_task: </run/rspamd/worker-controller.sock> learned message as ham" >&2');
  '';
}
