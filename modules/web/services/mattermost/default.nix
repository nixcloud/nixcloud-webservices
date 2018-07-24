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
          TLS or STARTTLS can be used to connect to the server.
        '';
      };
      EnableSMTPAuth = mkOption {
        type = types.bool;
        default = false;
        description = ''
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
          The user name to connect to. Often the email address but sometimes just the part before the @ like 'js' for js@lastlog.de for instance.
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
      boolToString = value: if value then "true" else "false";

      path = builtins.toPath "/${config.proxyOptions.domain}/${config.proxyOptions.path}";
      siteUrl = "${if (config.proxyOptions.https.mode == "on") then "https" else "http"}:/${path}";

      mattermostConf = foldl recursiveUpdate defaultConfig
        [ { ServiceSettings.SiteURL = "${siteUrl}"; # "https://chat.example.com";
            ServiceSettings.ListenAddress = "localhost:${toString config.proxyOptions.port}";
            TeamSettings.SiteName = config.siteName;
            SqlSettings.DriverName = "postgres";
            SqlSettings.DataSource = "postgres:///mattermost?host=${config.database.mattermost.socketPath}";
            EmailSettings = {
              SendEmailNotifications = "${boolToString config.EmailSettings.SendEmailNotifications}";
              ConnectionSecurity = "${config.EmailSettings.ConnectionSecurity}";
              EnableSMTPAuth = "${toString config.EmailSettings.EnableSMTPAuth}";
              SMTPPassword = "${config.EmailSettings.SMTPPassword}";
              SMTPPort = "${toString config.EmailSettings.SMTPPort}";
              SMTPServer = "${config.EmailSettings.SMTPServer}";
              SMTPUsername = "${config.EmailSettings.SMTPUsername}";
              RequireEmailVerification = "${boolToString config.EmailSettings.RequireEmailVerification}";
            };
          }
          config.extraConfig
        ];
      mattermostConfJSON = pkgs.writeText "mattermost-config-raw.json" (builtins.toJSON mattermostConf);
    in 
      lib.mkIf config.enable {

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

        systemd.services.mattermost = {
         description = "${config.uniqueName} main service (mattermost)";

          wantedBy      = [ "multi-user.target" ];
          after         = [ "network.target" ];

          preStart = ''
            mkdir -p ${config.stateDir}/www/{data,config,logs}
            ln -sf ${pkgs.mattermost}/{bin,fonts,i18n,templates,client} ${config.stateDir}/www
            ln -sf ${mattermostConfJSON} ${config.stateDir}/www/config/config.json
          '';

          serviceConfig = {
            User = "mattermost";
            Group = "mattermost";
            Restart = "on-failure";
            WorkingDirectory = "${config.stateDir}/www";
            PrivateTmp = true;
            #ExecStart = "${pkgs.mattermost}/bin/mattermost";
            ExecStart = "${pkgs.mattermost}/bin/mattermost-platform";
            LimitNOFILE = "49152";
          };
        };

        #tests.wanted = [ ./test.nix ];
      };
}
