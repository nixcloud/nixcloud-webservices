{ config, pkgs, lib, options, ... }:

with lib;

let
  cfg = config.nixcloud.email;
  checks_incomming = concatStringsSep "\n" (map (x: "${x.pattern} ${x.action}") (filter (x: x.direction != "outgoing") cfg.headerChecks));
  checks_outgoing = concatStringsSep "\n" (map (x: "${x.pattern} ${x.action}") (filter (x: x.direction != "incomming") cfg.headerChecks));
  relay_passwd = concatStringsSep "\n" (mapAttrsToList (user: password: "${cfg.relay.host} ${user}:${password}") cfg.relay.passwords);
in
{
  imports = [ ./virtual-mail-users.nix ];

  options.nixcloud.email = {
    enable = mkOption {
      default = false;
      description = ''
        nixcloud.io email abstraction, optimized for simple usage yet supporting complex features.
      '';
    };
    ipAddress = mkOption {
      example = "1.2.3.4";
      description = ''
        The IPv4 address used for the email service.
      '';
    };
    ip6Address = mkOption {
      example = "2001:0db8:85a3:0000:0000:8a2e:0370:7334";
      description = ''
        The IPv6 address used for the email service. Note: You need to set the reverse PTR correctly or you can't send emails to gmail.com for instance.
      ''; #'
    };
    domains = mkOption {
      type = types.listOf (types.str);
      example = [ "example.com" ];
      description = ''
        The domains for which the mailserver is responsible.
      '';
    };
    hostname = mkOption {
      type = types.str;
      example = "mail.example.com";
      default = config.networking.hostName;
      description = ''
        The domain the MX record points to and hostname needs not be listed in domains. Used by Postfix and ACME.
      '';
    };
    enableSpamassassin = mkOption {
      type = types.bool;
      default = true;
      description = ''
        SpamAssassin is the #1 Open Source anti-spam platform giving system administrators a filter to classify email and block spam (unsolicited bulk email).
      '';
    };
    enableGreylisting = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable the Postfix policy server implementing greylisting developed by David Schweikert.
      '';
    };
    enableMailQuota = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Dovecot2 mail quotas - https://wiki2.dovecot.org/Quota
      '';
    };
    enableDKIM = mkOption {
      type = types.bool;
      default = true;
      description = ''
        A community effort to develop and maintain a C library for producing DKIM-aware applications and an open source milter for providing DKIM servicei (http://opendkim.org/).
      '';
    };
    enableTLS = mkOption {
      type = types.bool;
      default = true;
      description = ''
        If you want to use TLS (aka. SSL) for your server you can configure this using `nixcloud.TLS` witht the `hostname` identifier.

        The default `nixcloud.TLS` setting is to use let's encrypt ACME. If you want to use your own certificates (usersupplied), use:

            nixcloud.TLS.certs = {
              "example.com" = {
                mode = {
                  tls_certificate="/tmp/fullchain.pem";
                  tls_certificate_key="/tmp/key.pem";
                };
                email = "foo@example.com";
              };
            };

        For testing you can use (selfsigned), like this:

          nixcloud.TLS.certs = {
            "example.com" = {
              mode = "selfsigned";
            };
          };

      ''; #'
    };
    enableSPFPolicy = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enforce the Sender Policy Framework.
      '';
    };
    users = mkOption {
      type = types.listOf (types.submodule (import ./virtual-mail-submodule.nix));
      example = [ { name = "js"; domain = "nixcloud.io"; password="qwertz"; } ];
      default = [];
      description = "A list of virtual mail users for which the password is managed via this abstraction";
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
        description = "An attribute set where the keys are the mail users and the values are the passwords of those users";
      };
    };
    headerChecks = mkOption {
      type = types.listOf (types.submodule ({ ... }:
        {
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
              description = "The action to be executed when the pattern is matched";
            };
            direction = mkOption {
              type = types.enum ["incomming" "outgoing" "both"];
              default = "both";
              example = "incoming";
              description = "Whether to filter on incomming smtp port (submission) or on outgoing smtp port (25) or both.";
            };
          };
        }));
      default = [];
      description = "Header Checks on incomming and outgoing smtp port";
      example = [ { pattern = "/^X-Spam(.*)/"; action = "IGNORE"; direction = "incomming"; } ];
    };
  };

  config = mkIf (config.nixcloud.email.enable == true)
    (mkMerge [ 

      ({ 
        networking = {
          firewall = {
            allowPing = true;
            allowedTCPPorts = [
              25               # master (postfix)
              143              # imap (dovecot)
              587              # dovecot (submission)
              993              # imaps (dovecot)
              4190             # sieve
            ];
          };
        };
      })


      ({
        services.mailUsers.users = cfg.users; 
      })
      
      (mkIf cfg.enableSpamassassin {
        services.spamassassin = {
          enable = true;
          #debug = true;
          config = ''
            #rewrite_header Subject [***** SPAM _SCORE_ *****]
            required_score          5.0
            use_bayes               1
            bayes_auto_learn        1
            add_header all Status _YESNO_, score=_SCORE_ required=_REQD_ tests=_TESTS_ autolearn=_AUTOLEARN_ version=_VERSION_
          '';
        };
      })

      (mkIf cfg.enableTLS {
        nixcloud.reverse-proxy.enable = true;

        systemd.services.postfix.after = [ "nixcloud.TLS-certificates.target" ];
        systemd.services.postfix.wants = [ "nixcloud.TLS-certificates.target" ];
        
        systemd.services.dovecot2.after = [ "nixcloud.TLS-certificates.target" ];
        systemd.services.dovecot2.wants = [ "nixcloud.TLS-certificates.target" ];
        
        nixcloud.TLS.certs = {
          "${cfg.hostname}" = {
            # FIXME: we could add this later if someone wants it
            #extraDomains = builtins.listToAttrs (fold (el: c: c ++ [ { name = "${el}"; value = null; } ] ) [] cfg.domains);
            email = null;
            reload = [ "postfix.service" "dovecot2.service" ];
          };
        };
      })

      # FIXME: when using nixcloud DNS we want the pubkey during nix evaluation time to generate
      #        a prober DNS entry for uploading BUT the keys generation is delayed and takes place
      #        during service activation and therefore we can't generate the DNS entry just yet
      (mkIf cfg.enableDKIM {
        users.users.postfix.extraGroups = [ "opendkim" ];
        services.opendkim = {
          enable = true;
          selector = "mail";
          keyPath = "/var/lib/dkim/keys/";
          domains = "csl:${lib.concatStringsSep "," cfg.domains}";
          configFile = pkgs.writeText "opendkim.conf" ''
            UMask 0002
          '';
        };
      })

      # FIXME: add a mkOption to set domains or email addresses on a white list
      # FIXME: 1. if no SPF found -> greylist
      #        2. if no SPF found + valid DMARC signature -> greylist
      #        3. if SPF + no valid DMARC signature -> greylist
      #        4. if SPF + valid DMARC signature -> receive directly
      (mkIf cfg.enableGreylisting {
        services.postgrey = {
          enable = true;
        };
      })

      { 
        services.postfix = {
          enable = true;
          enableHeaderChecks = true;
          masterConfig = {
            smtp_inet = {
              args = [ 
               "-o" "smtp_header_checks=header_checks_incomming"
              ] ++ optionals cfg.enableSpamassassin [ "-o" "content_filter=spamassassin" ];
            };
          } // optionalAttrs cfg.enableSpamassassin {
            spamassassin = {
              command = "pipe";
              args = [ "user=spamd" "argv=${pkgs.spamassassin}/bin/spamc" "-f" "-e" "/run/wrappers/bin/sendmail" "-oi" "-f" ''''${sender}'' ''''${recipient}'' ];
              privileged = true;
            }; 
          } // optionalAttrs cfg.enableSPFPolicy {
            policydspf = {
              command = "spawn";
              args = [ "user=nobody" "argv=${pkgs.python36Packages.pypolicyd-spf}/bin/policyd-spf" ];
              privileged = true;
              maxproc = 0;
            }; 
          };
          setSendmail = true;
          hostname = cfg.hostname;
          destination = [
            "localhost"
          ];
          enableSubmission = true;
          submissionOptions = {
            "smtpd_tls_security_level" = "encrypt";
            "smtpd_sasl_auth_enable" = "yes";
            "smtpd_client_restrictions" = "permit_sasl_authenticated,reject";
            "smtpd_sasl_type" = "dovecot";
            "smtpd_sasl_path" = "private/auth";
            "smtp_header_checks" = "regexp:/etc/postfix/header_checks_outgoing";
          };

          mapFiles."header_checks_outgoing" = pkgs.writeText "header_checks_outgoing" checks_outgoing;
          mapFiles."header_checks_incomming" = pkgs.writeText "header_checks_incomming" checks_incomming;

          config = {
            smtpd_tls_auth_only = true;
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
              "reject_unknown_client_hostname" # reject reverse PTR not matching hostname
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
            ] ++ optional cfg.enableMailQuota "check_policy_service inet:localhost:${config.services.dovecot2.quotaPort}" # quota
              ++ optional cfg.enableGreylisting "check_policy_service unix:/var/run/postgrey.sock" # postgrey
              ++ optional cfg.enableSPFPolicy "check_policy_service unix:private/policydspf"; # policyd-spf
          } // optionalAttrs cfg.enableDKIM {
            smtpd_milters = [ "unix:/run/opendkim/opendkim.sock" ];
            non_smtpd_milters = [ "unix:/run/opendkim/opendkim.sock" ];
          } // optionalAttrs (cfg.relay.host != null) {
            smtp_sasl_auth_enable = true;
            smtp_sasl_security_options = [ "noanonymous" "noplaintext" ];
            smtp_sasl_tls_security_options = [ "noanonymous" ];
            smtp_sasl_password_maps = "hash:/etc/postfix/relay_passwd";
          };
        } // optionalAttrs (cfg.enableTLS) {
          sslCert = config.nixcloud.TLS.certs.${cfg.hostname}.tls_certificate;
          sslKey  = config.nixcloud.TLS.certs.${cfg.hostname}.tls_certificate_key;
        } // optionalAttrs (cfg.relay.host != null) {
          relayHost = cfg.relay.host;
          relayPort = cfg.relay.port;
          mapFiles."relay_passwd" = pkgs.writeText "relay_passwd" relay_passwd;
        };

        services.dovecot2 = {
          enable = true;
          enableImap = true;
          enableLmtp = true;
          enablePAM = false;
          enableQuota = true;
          mailLocation = "maildir:/var/lib/virtualMail/%d/users/%n/mail";

          mailUser = "virtualMail";
          mailGroup = "virtualMail";


          modules = [ pkgs.dovecot_pigeonhole ];

          protocols = [ "sieve" ];

          sieveScripts = {
            before = pkgs.writeText "before.sieve" ''
              require ["fileinto", "reject", "envelope", "mailbox", "reject"];
              
              if header :contains "X-Spam-Flag" "YES" {
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

          extraConfig = ''
            mail_home = /var/lib/virtualMail/%d/users/%n/

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
              sieve = /var/lib/virtualMail/%d/users/%n/sieve.active
              sieve_dir = /var/lib/virtualMail/%d/users/%n/sieve
            }

            service managesieve-login {
            }
            service managesieve {
            }
          '';
        } // optionalAttrs (cfg.enableTLS) { 
            sslServerCert = config.nixcloud.TLS.certs.${cfg.hostname}.tls_certificate;
            sslServerKey  = config.nixcloud.TLS.certs.${cfg.hostname}.tls_certificate_key;
        }; 
      }
    ]);
}
