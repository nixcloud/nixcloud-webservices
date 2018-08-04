{ config, pkgs, lib, mkUniqueUser, mkUniqueGroup, ... }:
with lib;
{
  options = {
    siteName = mkOption {
      default = "Mattermost";
      description = "Name of the Mattermost instance";
    };
    extraConfig = mkOption {
      type = types.attrs;
      default = { };
      description = ''
        Addtional configuration options as Nix attribute set in config.json schema.
      '';
    };
    EmailSettings = {
      SendEmailNotifications = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Email notifications are used to inform offline users of chat activity.
        '';
      };
      ConnectionSecurity = mkOption {
        type = types.str;
        default = "STARTTLS";
        description = ''
          'TLS' or 'STARTTLS' can be used to connect to the server.
        '';
      };
      EnableSMTPAuth = mkOption {
        type = types.bool;
        default = false;
        description = ''
          If you sent emails using localhost you won't need authentification, in all other cases you probably will!
        '';
      };
      SMTPPassword = mkOption {
        type = types.str;
        default = "";
        description = ''
          The password for your email account using SMTP.
        '';
      };
      SMTPPort = mkOption {
        type = types.int;
        default = 587;
        description = ''
          The port to connect in order to send emails. Usually 25 or 587.
        '';
      };
      SMTPServer = mkOption {
        type = types.str;
        default = "";
        example = "mail.example.org";
        description = ''
          Mail host to connect to.
        '';
      };
      SMTPUsername = mkOption {
        type = types.str;
        default = "";
        description = ''
          The user name to connect to. Often the email address but sometimes just the part before the @ like 'info' for info@nixcloud.io for instance.
        '';
      };
      RequireEmailVerification = mkOption {
        type = types.bool;
        default = false;
        description = ''
          RequireEmailVerification forces opt-in via email.
        '';
      };
    };
  };

  meta = {
    description = "A hybrid cloud enterprise messaging workspace";
    homepage = "https://mattermost.com/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ qknight ];
    meta.platforms = lib.platforms.linux;
  };
  config =
    let
      defaultConfig = builtins.fromJSON (readFile "${pkgs.mattermost}/config/config.json");

      path = builtins.toPath "/${config.proxyOptions.domain}/${config.proxyOptions.path}";
      siteUrl = "${if (config.proxyOptions.https.mode == "on") then "https" else "http"}:/${path}";

      mattermostConf = foldl recursiveUpdate defaultConfig
        [ { ServiceSettings.SiteURL = "${siteUrl}"; # "https://chat.example.com";
            ServiceSettings.ListenAddress = "localhost:${toString config.proxyOptions.port}";
            TeamSettings.SiteName = config.siteName;
            SqlSettings = {
              DriverName = "postgres";
              DataSource = "postgres:///mattermost?host=${config.database.mattermost.socketPath}";
              # SECURITY/FIXME: hardcoded 
              AtRestEncryptKey = "7rAh6iwQCkV4cA1Gsg3fgGOXJAQ43QVg";
            };
            FileSettings = {
              # SECURITY/FIXME: hardcoded 
              PublicLinkSalt = "A705AklYF8MFDOfcwh3I488G8vtLlVip";
            };
            EmailSettings = {
              SendEmailNotifications = config.EmailSettings.SendEmailNotifications;
              ConnectionSecurity = "${config.EmailSettings.ConnectionSecurity}";
              EnableSMTPAuth = config.EmailSettings.EnableSMTPAuth;
              SMTPPassword = "${config.EmailSettings.SMTPPassword}";
              SMTPPort = "${toString config.EmailSettings.SMTPPort}";
              SMTPServer = "${config.EmailSettings.SMTPServer}";
              SMTPUsername = "${config.EmailSettings.SMTPUsername}";
              RequireEmailVerification = config.EmailSettings.RequireEmailVerification;
              # SECURITY/FIXME: hardcoded 
              InviteSalt = "bjlSR4QqkXFBr7TP4oDzlfZmcNuH9YoS";
              # SECURITY/FIXME: hardcoded 
              PasswordResetSalt = "vZ4DcKyVVRlKHHJpexcuXzojkE5PZ5eL";
            };
          }
          config.extraConfig
        ];
      # https://docs.mattermost.com/administration/command-line-tools.html#mattermost-config-validate
      mattermostConfJSON = pkgs.writeText "mattermost-config-raw.json" (builtins.toJSON mattermostConf);
      # mattermost config validate
      checkAndFormatMattermostConfigfile = configFile:
      pkgs.stdenv.mkDerivation {
        name = "mattermost_check_config";
        src = "";
        buildInputs = with pkgs; [ jq ];
        phases = [ "installPhase" ];
        installPhase = ''
          mkdir $out/
          cat ${configFile} | jq '.' > $out/mattermost-config-raw.json
          # next line prevents a segfault if configuration contains issues
          ln -sf ${pkgs.mattermost}/{bin,fonts,i18n,templates,client} $out
          cd $out
          
          set +e
          t=$(${pkgs.mattermost}/bin/mattermost-platform config validate -c $out/mattermost-config-raw.json 2>&1)
          status=$?
          set -e
          
          if [ "$status" != "0" ]; then
            echo "=========== mattermost syntax check fail ==========="
            echo -e "$t"
            echo "   -> $out/mattermost-config-raw.json"
            echo "=========== /mattermost syntax check fail ==========="
            echo "You need to fix your mattermost configuration!!1!"
            exit 1
          else
            echo "=========== mattermost syntax check ==========="
            echo "syntax is ok! YAY! \o/"
            echo "   -> $out/mattermost-config-raw.json"
            echo "=========== /mattermost syntax check ==========="
          fi
        '';
      };

    in 
      lib.mkIf config.enable ({

        # inject the leaps websocket
        proxyOptions.websockets = {
          ws = {
            subpath = "/api/v4/websocket";
          };
        };

        users.mattermost = {
          description = "Mattermost server user";
          home        = "${config.stateDir}/www";
          createHome  = true;
          group       = "mattermost";
        };
        groups.mattermost = {};

        database.mattermost = {
          user = "mattermost";
          owners = [ "mattermost" ];
          type = "postgresql";
        };

        systemd.services.mattermost = 
          assert (config.proxyOptions.path != "/") || abort "Mattermost has no support for subdirectories yet, see https://mattermost.uservoice.com/forums/306457-general/suggestions/12468372-install-mattermost-in-a-subdirectory"; 
            {
              description = "${config.uniqueName} main service (mattermost)";

              wantedBy      = [ "multi-user.target" ];
              after         = [ "network.target" ];

              preStart = ''
                mkdir -p ${config.stateDir}/www/{data,config,logs}
                ln -sf ${pkgs.mattermost}/{bin,fonts,i18n,templates,client} ${config.stateDir}/www
                ln -sf ${checkAndFormatMattermostConfigfile mattermostConfJSON}/mattermost-config-raw.json ${config.stateDir}/www/config/config.json
              '';

              serviceConfig = {
                User = "mattermost";
                Group = "mattermost";
                Restart = "on-failure";
                WorkingDirectory = "${config.stateDir}/www";
                PrivateTmp = true;
                ExecStart = "${pkgs.mattermost}/bin/mattermost-platform";
                LimitNOFILE = "49152";
              };
            };

        tests.wanted = [ ./test.nix ];
      });
}
