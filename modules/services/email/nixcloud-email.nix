{ config, pkgs, lib, ... } @ args:

let
  inherit (lib) types mkOption mkRenamedOptionModule;
  cfg = config.nixcloud.email;

  excludeDirection = dir: lib.filter (x: x.direction != dir) cfg.headerChecks;
  checksIncoming = lib.concatMapStringsSep "\n" (x: "${x.pattern} ${x.action}") (excludeDirection "outgoing");
  checksOutgoing = lib.concatMapStringsSep "\n" (x: "${x.pattern} ${x.action}") (excludeDirection "incoming");
  relayPasswd = lib.concatStringsSep "\n" (lib.mapAttrsToList (user: password: "${cfg.relay.host} ${user}:${password}") cfg.relay.passwords);

  postfixCfg = config.services.postfix;
  rspamdCfg = config.services.rspamd;
  dovecot2Cfg = config.services.dovecot2;

  sniString = x:
    let
      sslCert = config.nixcloud.TLS.certs."${cfg.fqdn}".tls_certificate;
      sslKey  = config.nixcloud.TLS.certs."${cfg.fqdn}".tls_certificate_key;
    in ''
      local_name mail.${x} {
        ssl_cert = <${sslCert}
        ssl_key = <${sslKey}
      }
  '';
  dnsRecordsScript = let
    dnsRecordsFile = pkgs.writeText "dnsRecords.zone" ''
       ${cfg.dnsRecords}
    '';
  in pkgs.writeScriptBin "dnsRecords" ''
     cat ${dnsRecordsFile}
  '';

  # generate attrSet for a single webmail webservice
  mkWebMailWebService = primaryFQDN: extraFQDN: port: {
    enable = true;
    proxyOptions = {
      domain = "${extraFQDN}";
      port = port;
      TLS = "${primaryFQDN}";
    };
  };
  # unique set of primary FQDN and additional domains in nixcloud.email, prefixed with `mail.` depending on `autoMailDomain`
  rcWebMailFQDNs = map (fqdn: (lib.optionalString (cfg.webmail.autoMailDomain && ((builtins.match "^mail\..+" fqdn) == null)) "mail.") + fqdn) (lib.unique([ cfg.fqdn ] ++ cfg.domains));

  stateDir = "/var/lib/dovecot";

  mkBinScripts = args: pkgs.stdenv.mkDerivation ({
    buildInputs = with pkgs; [ makeWrapper bash ];
    buildCommand = ''
      mkdir -p $out/bin
      cp $src/* $out/bin/
      chmod a+x $out/bin/*
      patchShebangs $out/bin

      for file in $out/bin/*; do
        wrapProgram $file \
          --set PATH "${pkgs.coreutils}/bin:${pkgs.rspamd}/bin"
      done
    '';
  } // args);
  filterBin = mkBinScripts {
    name = "nixcloud-dovecot-filter-bin";
    src = ./dovecot/filter_bin;
  };
  pipeBin = mkBinScripts {
    name = "nixcloud-dovecot-pipe-bin";
    src = ./dovecot/pipe_bin;
  };
in {
  imports = [
    (import ./virtual-mail-users.nix ({virtualMailDir = cfg.virtualMailDir;} // args))
    (mkRenamedOptionModule [ "nixcloud" "email" "enableSpamassassin" ] [ "nixcloud" "email" "enableRspamd" ])
    (mkRenamedOptionModule [ "nixcloud" "email" "hostname" ] [ "nixcloud" "email" "fqdn" ])
  ];

  options.nixcloud.email = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        nixcloud.io email abstraction, optimized for simple usage yet
        supporting complex features.
      '';
    };
    ipAddress = mkOption {
      type = types.str;
      example = "1.2.3.4";
      description = ''
        The IPv4 address used for the email service.
      '';
    };
    ip6Address = mkOption {
      type = types.str;
      example = "2001:0db8:85a3:0000:0000:8a2e:0370:7334";
      description = ''
        The IPv6 address used for the email service. Note: You need to set the
        reverse PTR correctly or you can't send emails to gmail.com for
        instance.
      ''; #'
    };
    domains = mkOption {
      type = types.listOf types.str;
      example = [ "example.com" ];
      description = ''
        The domains for which the mailserver is responsible.
      '';
    };
    fqdn = mkOption {
      type = types.str;
      example = "mail.example.com";
      default = config.networking.hostName;
      description = ''
        The FQDN (fully qualified domain name) of your mailserver.
      '';
    };
    dnsRecords = mkOption {
      type = types.separatedString "";
      default = "";
      description = ''
        A DNS records file for the configured domains.
      '';
    };
    enableRspamd = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Fast, free and open-source spam (unsolicited bulk email) filtering
        system.
      '';
    };
    enableGreylisting = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable the Postfix policy server implementing greylisting developed by
        David Schweikert.
      '';
    };
    enableMailQuota = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Dovecot2 mail quotas
        (<link xlink:href="https://wiki2.dovecot.org/Quota"/>)
      '';
    };
    enableDKIM = mkOption {
      type = types.bool;
      default = true;
      description = ''
        A community effort to develop and maintain a C library for producing
        DKIM-aware applications and an open source milter for providing DKIM
        servicei (<link xlink:href="http://opendkim.org/"/>).
      '';
    };
    enableTLS = mkOption {
      type = types.bool;
      default = true;
      description = ''
        If you want to use TLS (aka. SSL) for your server you can configure
        this using <option>nixcloud.TLS</option> with the
        <option>hostname</option> identifier.

        The default <option>nixcloud.TLS</option> setting is to use let's
        encrypt ACME. If you want to use your own certificates (usersupplied),
        use:

        <programlisting>
        nixcloud.TLS.certs = {
          "example.com" = {
            mode = {
              tls_certificate="/tmp/fullchain.pem";
              tls_certificate_key="/tmp/key.pem";
            };
            email = "foo@example.com";
          };
        };
        </programlisting>

        For testing you can use (selfsigned), like this:

        <programlisting>
        nixcloud.TLS.certs = {
          "example.com" = {
            mode = "selfsigned";
          };
        };
        </programlisting>

      ''; #'
    };
    enableSPFPolicy = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enforce the Sender Policy Framework.
      '';
    };
    webmail = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Provide a webmail interface for `nixcloud.email`-enabled domains
        '';
      };
      autoMailDomain = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Assumes webmail should be made available under `mail.<domain>`.
          Uses `domain` as defined if set to `false`.
        '';
      };
    };
    users = mkOption {
      type = types.listOf (types.submodule {
        imports = [ ./virtual-mail-submodule.nix ];
      });
      example = lib.literalExample ''
        [ { name = "js"; domain = "nixcloud.io"; password="qwertz"; } ]
      '';
      default = [];
      description = ''
        A list of virtual mail users for which the password is managed via this
        abstraction.
      '';
    };
    relay = {
      host = mkOption {
        type = types.nullOr types.str;
        example = "mail.mydomain.tld";
        default = null;
        description = "The mail host which should be configured as relay";
      };
      port = mkOption {
        type = types.int;
        example = 25;
        default = 587;
        description = "The port of the relay host";
      };
      passwords = mkOption {
        type = types.attrsOf types.str;
        example = {
          "alice@foo.tld" = "supersafepassword123";
          "bob@bar.tld" = "iAmB0b!";
        };
        default = {};
        description = ''
          An attribute set where the keys are the mail users and the values are
          the passwords of those users.
        '';
      };
    };
    headerChecks = mkOption {
      type = types.listOf (types.submodule {
        options = {
          pattern = mkOption {
            type = types.str;
            default = "/^.*/";
            example = "/^X-Mailer:/";
            description = "A regexp pattern matching the header";
          };
          action = mkOption {
            type = types.str;
            default = "DUNNO";
            example = "BCC mail@example.com";
            description = ''
              The action to be executed when the pattern is matched
            '';
          };
          direction = mkOption {
            type = types.enum ["incoming" "outgoing" "both"];
            default = "both";
            example = "incoming";
            description = ''
              Whether to filter on incoming smtp port (submission) or on
              outgoing smtp port (25) or both.
            '';
          };
        };
      });
      default = [];
      description = "Header Checks on incoming and outgoing smtp port";
      example = lib.literalExample ''
        [ { pattern = "/^X-Spam(.*)/"; action = "IGNORE"; direction = "incoming"; } ]
      '';
    };

    virtualMailDir = mkOption {
      description = "Path used to store the virtual mail boxes of users";
      default = "/var/lib/virtualMail";
      example = "/home/mail";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    (lib.mkIf cfg.enableTLS {
      nixcloud.reverse-proxy.enable = true;

      systemd.services.postfix.after = [ "nixcloud.TLS-certificates.target" ];
      systemd.services.postfix.wants = [ "nixcloud.TLS-certificates.target" ];

      systemd.services.dovecot2.after = [ "nixcloud.TLS-certificates.target" ];
      systemd.services.dovecot2.wants = [ "nixcloud.TLS-certificates.target" ];

      nixcloud.TLS.certs."${cfg.fqdn}" = {
        domain = "${cfg.fqdn}";
        extraDomains = lib.unique((map (x: "mail.${x}") cfg.domains) ++ rcWebMailFQDNs);
        reload = [ "postfix.service" "dovecot2.service" ];
      };

      # https://github.com/nixcloud/nixcloud-webservices/issues/21
      # https://github.com/NixOS/nixpkgs/pull/39507
      security.dhparams = {
        enable = true;
        params = {
          dovecot2 = 2048;
        };
      };
    })

    ({
      nixcloud.email.dnsRecords = lib.concatMapStringsSep "" (domain: ''
        ${domain}. IN     A ${cfg.ipAddress}
        ${domain}. IN  AAAA ${cfg.ip6Address}
        @          IN    MX ${domain}.
        mail       IN CNAME ${domain}.
        imap       IN CNAME ${domain}.
        pop3       IN CNAME ${domain}.
        smtp       IN CNAME ${domain}.
        ${domain}. IN   TXT "v=spf1 a:${domain} -all"
      '') (lib.unique([cfg.fqdn] ++ cfg.domains));
      environment.systemPackages = [ dnsRecordsScript ];
    })

    (lib.mkIf cfg.webmail.enable {
      nixcloud.email.dnsRecords = lib.concatMapStringsSep "" (domain: ''
        ${domain}. IN    A ${cfg.ipAddress}
        ${domain}. IN AAAA ${cfg.ip6Address}
      '') rcWebMailFQDNs;
      nixcloud.webservices.roundcube = let
	# makes portMap contain an attrSet where the key is the FQDN and the value a port for the
	# corresponding webservice, e.g. `{ "domain.a" = 8993; "domain.b" = 8994; "domain.c" = 8995; }`
	portMap = lib.listToAttrs (lib.imap0 (i: v: {name = v; value = 8993+i;}) rcWebMailFQDNs);
      in lib.fold (el: c: c // {"${el}" = mkWebMailWebService cfg.fqdn el portMap."${el}";}) {} (rcWebMailFQDNs);
    })

    (lib.mkIf cfg.enableDKIM {
      users.users.postfix.extraGroups = [ "opendkim" ];
      services.opendkim = {
        enable = true;
        selector = "mail";
        keyPath = lib.mkDefault "/var/lib/dkim/keys/";
        domains = "csl:${lib.concatStringsSep "," cfg.domains}";
        configFile = pkgs.writeText "opendkim.conf" ''
          UMask 0002
        '';
      };
    })

    (lib.mkIf cfg.enableGreylisting {
      services.postgrey.enable = true;
    })

    (lib.mkIf cfg.enableRspamd {
      assertions = [{
        assertion = lib.versionAtLeast pkgs.rspamd.version "1.7.3";
        message = ''
          The NixCloud Rspamd support requires at least version 1.7.3 (found ${pkgs.rspamd.version}).
          Hint: version 1.7.3 is found in NixOS 18.09
        '';
      }];

      services.rspamd = {
        enable = true;
        locals."milter_headers.conf".text = ''
          use = ["x-spamd-result", "x-spam-status"];
        '';
        locals."groups.conf".text = ''
          group "bayes_user" {
              symbol {
                  BAYES_SPAM_USER {
                      weight = 4.0;
                      description = "Message probably spam, probability: ";
                  }
              }
              symbol {
                  BAYES_HAM_USER {
                      weight = -3.0;
                      description = "Message probably ham, probability: ";
                  }
              }
          }

          group "upstream" {
            symbol {
              UPSTREAM_SCORE = {
                weight = 1.0;
                description = "Loaded upstream score";
              }
            }
          }
        '';
        locals."settings.conf".text = ''
          milter {
            id = "milter";
            apply {
              groups_disabled = ["bayes_user", "upstream"];
            }
          }
          delivery {
            id = "delivery";
            apply {
              groups_enabled = ["bayes_user", "upstream"];
            }
          }
        '';
        locals."statistic.conf".source = "${./rspamd}/statistic.conf";
        localLuaRules = "${./rspamd}/rspamd.local.lua";
        extraConfig = ''
          settings {
            .include(try=true,priority=1,duplicate=merge) "$LOCAL_CONFDIR/local.d/settings.conf"
            .include(try=true; priority=10) "$LOCAL_CONFDIR/override.d/settings.conf"
          }
        '';

        workers.rspamd_proxy = {
          bindSockets = [{
            socket = "/run/rspamd/rspamd-milter.sock";
            mode = "0664";
          }];
          count = 1; # Do not spawn too many processes of this type
          extraConfig = ''
            milter = yes; # Enable milter mode
            timeout = 120s; # Needed for Milter usually

            upstream "local" {
              default = yes; # Self-scan upstreams are always default
              self_scan = yes; # Enable self-scan
              settings = "milter";
            }
          '';
        };
        workers.controller = {
          type = "controller";
          count = 1;
          bindSockets = [{
            socket = "/run/rspamd/worker-controller.sock";
            mode = "0666";
          }];
          includes = [];
        };

      };
      systemd.services.postfix = {
        after = [ "rspamd.service" ];
        requires = [ "rspamd.service" ];
      };
      users.users.${postfixCfg.user}.extraGroups = [ rspamdCfg.group ];
      services.postfix.config = {
        smtpd_milters = [
          "unix:/run/rspamd/rspamd-milter.sock"
        ];
        milter_protocol = "6";
        milter_mail_macros = "i {mail_addr} {client_addr} {client_name} {auth_type} {auth_authen} {auth_author} {mail_addr} {mail_host} {mail_mailer}";
      };
      systemd.services.dovecot2.preStart = ''
        rm -rf '${stateDir}/imap_sieve'
        mkdir '${stateDir}/imap_sieve'
        cp -p "${./dovecot}/imap_sieve"/*.sieve '${stateDir}/imap_sieve/'
        for k in "${stateDir}/imap_sieve"/*.sieve ; do
          ${pkgs.dovecot_pigeonhole}/bin/sievec  "$k"
        done
        chown -R '${dovecot2Cfg.mailUser}:${dovecot2Cfg.mailGroup}' '${stateDir}/imap_sieve'
      '';
    })

    {
      networking.firewall = {
        allowPing = lib.mkDefault true;
        allowedTCPPorts = [
          25   # master (postfix)
          143  # imap (dovecot)
          587  # dovecot (submission)
          993  # imaps (dovecot)
          4190 # sieve
        ] ++ lib.optionals cfg.webmail.enable [
          80  # HTTP
          443 # HTTPS
        ];
      };

      services.mailUsers.users = cfg.users;

      nixcloud.tests.wanted = [ ./test ];

      systemd.services.dovecot2.after = [ "postfix.service" ];

      services.postfix = {
        enable = true;
        enableHeaderChecks = true;
        masterConfig = {
          smtp_inet = {
            args = [
             "-o" "smtp_header_checks=header_checks_incoming"
            ];
          };
        } // lib.optionalAttrs cfg.enableSPFPolicy {
          policydspf = {
            command = "spawn";
            args = [ "user=nobody" "argv=${pkgs.python36Packages.pypolicyd-spf}/bin/policyd-spf" ];
            privileged = true;
            maxproc = 0;
          };
        };
        setSendmail = true;
        hostname = cfg.fqdn;
        destination = [
          "localhost"
        ];
        enableSubmission = true;
        submissionOptions = {
          smtpd_tls_auth_only = if cfg.enableTLS then "yes" else "no";
          smtpd_tls_security_level = if cfg.enableTLS then "encrypt" else "may";
          smtpd_sasl_auth_enable = "yes";
          smtpd_client_restrictions = "permit_sasl_authenticated,reject";
          smtpd_sasl_type = "dovecot";
          smtpd_sasl_path = "private/auth";
          smtp_header_checks = "regexp:/etc/postfix/header_checks_outgoing";
        };

        mapFiles."header_checks_outgoing" = pkgs.writeText "header_checks_outgoing" checksOutgoing;
        mapFiles."header_checks_incoming" = pkgs.writeText "header_checks_incoming" checksIncoming;

        config = {
          smtpd_tls_auth_only = cfg.enableTLS;
          message_size_limit = "100480000";
          mailbox_size_limit = "1004800000";
          virtual_mailbox_domains = cfg.domains;
          virtual_transport = "lmtp:unix:private/lmtp-dovecot";

          smtp_bind_address = cfg.ipAddress;
          smtp_bind_address6 = cfg.ip6Address;

          smtpd_sasl_auth_enable = true;
          smtpd_sasl_security_options = "noanonymous";
          broken_sasl_auth_clients = true;

          smtpd_tls_received_header = true;
          smtpd_relay_restrictions = [
            "reject_non_fqdn_recipient"
            "reject_unknown_recipient_domain"
            "permit_mynetworks"
            "permit_sasl_authenticated"
            "reject_unauth_destination"
          ];
          smtpd_client_restrictions = [
            "permit_mynetworks"
            "permit_sasl_authenticated"
            "reject_unknown_reverse_client_hostname" # reject when no reverse PTR
          ];
          smtpd_helo_required = "yes";
          smtpd_helo_restrictions = [
            "permit_mynetworks"
            "permit_sasl_authenticated"
            "reject_invalid_helo_hostname"
            "reject_non_fqdn_helo_hostname"
            "reject_unknown_helo_hostname"
          ];

          # Add some security
          smtpd_recipient_restrictions = [
            "reject_unknown_sender_domain"    # prevents spam
            "reject_unknown_recipient_domain" # prevents spam
            "reject_unauth_pipelining"        # prevent bulk mail spam
            "permit_sasl_authenticated"
            "permit_mynetworks"
            "reject_unauth_destination"
          ] ++ lib.optional cfg.enableMailQuota "check_policy_service inet:localhost:${config.services.dovecot2.quotaPort}" # quota
            ++ lib.optional cfg.enableGreylisting "check_policy_service unix:/var/run/postgrey.sock" # postgrey
            ++ lib.optional cfg.enableSPFPolicy "check_policy_service unix:private/policydspf"; # policyd-spf
        } // lib.optionalAttrs cfg.enableDKIM {
          smtpd_milters = [ "unix:/run/opendkim/opendkim.sock" ];
          non_smtpd_milters = [ "unix:/run/opendkim/opendkim.sock" ];
        } // lib.optionalAttrs (cfg.relay.host != null) {
          smtp_sasl_auth_enable = true;
          smtp_sasl_security_options = [ "noanonymous" "noplaintext" ];
          smtp_sasl_tls_security_options = [ "noanonymous" ];
          smtp_sasl_password_maps = "hash:/etc/postfix/relay_passwd";
        };
      } // lib.optionalAttrs cfg.enableTLS {
        sslCert = config.nixcloud.TLS.certs."${cfg.fqdn}".tls_certificate;
        sslKey  = config.nixcloud.TLS.certs."${cfg.fqdn}".tls_certificate_key;
      } // lib.optionalAttrs (cfg.relay.host != null) {
        relayHost = cfg.relay.host;
        relayPort = cfg.relay.port;
        mapFiles."relay_passwd" = pkgs.writeText "relay_passwd" relayPasswd;
      };

      services.dovecot2 = {
        enable = true;
        enableImap = true;
        enableLmtp = true;
        enablePAM = false;
        enableQuota = true;
        mailLocation = "maildir:${cfg.virtualMailDir}/%d/users/%n/mail";

        mailUser = "virtualMail";
        mailGroup = "virtualMail";

        modules = [ pkgs.dovecot_pigeonhole ];

        protocols = [ "sieve" ];

        sieveScripts = {
          before = lib.mkIf cfg.enableRspamd "${./dovecot}/sieve/rspamd.sieve";
          after = "${./dovecot}/sieve/file-spam.sieve";
        };

        mailboxes = [
          { name = "Trash";
            auto = "create";
            specialUse = "Trash";
          }

          { name = "Drafts";
            auto = "create";
            specialUse = "Drafts";
          }

          { name = "Sent";
            auto = "create";
            specialUse = "Sent";
          }

          { name = "Spam";
            auto = "create";
            specialUse = "Junk";
          }
        ];

        extraConfig = lib.optionalString (cfg.enableTLS) ''
          # https://github.com/nixcloud/nixcloud-webservices/issues/21
          # https://github.com/NixOS/nixpkgs/pull/39507
          ssl_dh = <${config.security.dhparams.path}/dovecot2.pem
          ''
          +
          ''
          mail_home = ${cfg.virtualMailDir}/%d/users/%n/

          passdb {
            driver = passwd-file
            args = username_format=%n ${config.services.mailUsers.virtualMailEnv}/%d
          }

          userdb {
            driver = static
            args = uid=${config.services.dovecot2.mailUser} gid=${config.services.dovecot2.mailGroup}
          }

          service auth {
            unix_listener /var/lib/postfix/queue/private/auth {
              mode = 0660
              user = postfix
              group = postfix
            }
          }

          service lmtp {
            unix_listener /var/lib/postfix/queue/private/lmtp-dovecot {
              mode = 0660
              user = postfix
              group = postfix
            }
          }

          protocol lmtp {
            mail_plugins = $mail_plugins sieve
          }

          protocol imap {
            mail_plugins = $mail_plugins imap_sieve
          }

          plugin sieve {
            sieve = ${cfg.virtualMailDir}/%d/users/%n/sieve.active
            sieve_dir = ${cfg.virtualMailDir}/%d/users/%n/sieve
            ${lib.optionalString cfg.enableRspamd ''
              sieve_plugins = sieve_imapsieve sieve_extprograms
              sieve_pipe_bin_dir = ${pipeBin}/bin
              sieve_filter_bin_dir = ${filterBin}/bin
              sieve_global_extensions = +vnd.dovecot.pipe +vnd.dovecot.filter +vnd.dovecot.environment

              # From elsewhere to Spam folder
              imapsieve_mailbox1_name = Spam
              imapsieve_mailbox1_causes = COPY
              imapsieve_mailbox1_before = file:${stateDir}/imap_sieve/report-spam.sieve

              # From Spam folder to elsewhere
              imapsieve_mailbox2_name = *
              imapsieve_mailbox2_from = Spam
              imapsieve_mailbox2_causes = COPY
              imapsieve_mailbox2_before = file:${stateDir}/imap_sieve/report-ham.sieve
            ''}
          }

          service managesieve-login {
            ${lib.optionalString (cfg.enableTLS) ''
            inet_listener sieve {
              ssl = yes
            }
            ''}
          }
          service managesieve {
          }
        '' + lib.optionalString (cfg.enableTLS) (lib.fold (el: con: con + sniString el) "" config.nixcloud.email.domains);

      } // lib.optionalAttrs cfg.enableTLS {
        sslServerCert = config.nixcloud.TLS.certs."${cfg.fqdn}".tls_certificate;
        sslServerKey  = config.nixcloud.TLS.certs."${cfg.fqdn}".tls_certificate_key;
      };
    }
  ]);
}
