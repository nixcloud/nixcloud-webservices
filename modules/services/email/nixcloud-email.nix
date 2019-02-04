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

  # generate attrSet for a single webmail webservice
  mkWebMailWebService = fqdn: {
    enable = true;
    proxyOptions = {
      domain = "${fqdn}";
      port = 8993;
    };
  };
  # unique set of primary FQDN and additional domains in nixcloud.email, prefixed with `mail.` depending on `autoMailDomain`
  rcWebMailFQDNs = map (fqdn: (lib.optionalString (cfg.webmail.autoMailDomain) "mail.") + fqdn) (lib.unique([ cfg.fqdn ] ++ cfg.domains));

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
        extraDomains = map (x: "mail.${x}") cfg.domains;
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
      services.rspamd = {
        enable = true;
        extraConfig = ''
          extended_spam_headers = yes;
        '';

        workers.rspamd_proxy = {
          type = let
            inherit (config.system.nixos) release;
            isUnstable = lib.versionAtLeast release "19.03";
          in if isUnstable then "rspamd_proxy" else "proxy";
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
          before = pkgs.writeText "before.sieve" ''
            require ["fileinto", "reject", "envelope", "mailbox", "reject"];

            # spamassassin
            if header :contains "X-Spam-Flag" "YES" {
              fileinto :create "Spam";
              stop;
            }
            # rspamd
            if header :contains "X-Spam" "YES" {
              fileinto :create "Spam";
              stop;
            }
          '';
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

          plugin sieve {
            sieve = ${cfg.virtualMailDir}/%d/users/%n/sieve.active
            sieve_dir = ${cfg.virtualMailDir}/%d/users/%n/sieve
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
