{ config, pkgs, lib, mkUniqueUser, mkUniqueGroup, ... }:

let
  inherit (lib) mkOption types;

  # The main binary for Mattermost has changed from (mattermost-)platform to
  # just "mattermost".
  is5orNewer = let
    inherit (builtins.parseDrvName pkgs.mattermost.name) version;
  in lib.versionAtLeast version "5.0";
  mainBinary = if is5orNewer then "mattermost" else "platform";

  path = builtins.toPath "/${config.proxyOptions.domain}/${config.proxyOptions.path}";
  siteUrl = "${if (config.proxyOptions.https.mode == "on") then "https" else "http"}:/${path}";


  #FIXME quick hack so the manual can be build
  socketPath = if (config.database ? mattermost) then config.database.mattermost.socketPath else "`socketPath`";

  mattermostConfig = {
    ServiceSettings.SiteURL = "${siteUrl}"; # "https://chat.example.com";
    ServiceSettings.ListenAddress = "localhost:${toString config.proxyOptions.port}";
    TeamSettings.SiteName = config.siteName;
    SqlSettings = {
      DriverName = "postgres";
      DataSource = "postgres:///mattermost?host=${socketPath}";
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
  };

  # Merge module options with the upstream config file and validate it.
  cfgFile = pkgs.runCommand "mattermost-config.json" rec {
    nativeBuildInputs = [ pkgs.mattermost pkgs.jq ];
    defaultConfig = "${pkgs.mattermost}/config/config.json";
    moduleConfig = builtins.toJSON config.config;
    inherit mainBinary;
  } ''
    echo -n "$moduleConfig" | jq -s '.[0] * .[1]' "$defaultConfig" - > "$out"

    # Mattermost version 4.x segfaults if it can't find its prefix in $PWD.
    ${lib.optionalString is5orNewer "cd ${lib.escapeShellArg pkgs.mattermost}"}

    if output="$("$mainBinary" config validate -c "$out" 2>&1)"; then
      echo "=========== mattermost syntax check ============"
      echo "syntax is ok! YAY! \o/"
      echo "   -> $out"
      echo "=========== /mattermost syntax check ==========="
    else
      echo "=========== mattermost syntax check fail ==========="
      echo -e "$output"
      echo "   -> $out"
      echo "=========== /mattermost syntax check fail ==========="
      echo "You need to fix your mattermost configuration!!1!"
      exit 1
    fi
  '';

in {
  options = {
    siteName = mkOption {
      default = "Mattermost";
      description = "Name of the Mattermost instance";
    };
    config = mkOption {
      type = types.attrs;
      default = mattermostConfig;
      description = ''
        Configuration options for Mattermost as Nix attribute set in
        config.json schema. The documentation for these options can be found at
        <link xlink:href="https://docs.mattermost.com/administration/config-settings.html" />.
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

  config = lib.mkIf config.enable {
    # Re-define the default config, so that override is possible without
    # lib.mkOptionDefault.
    config = mattermostConfig;

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
      assert (config.proxyOptions.path == "/") || abort "Mattermost has no support for subdirectories yet, see 'https://mattermost.uservoice.com/forums/306457-general/suggestions/12468372-install-mattermost-in-a-subdirectory'. The path was ${config.proxyOptions.path}";
        {
          description = "${config.uniqueName} main service (mattermost)";

          wantedBy      = [ "multi-user.target" ];
          after         = [ "network.target" ];

          preStart = ''
            mkdir -p ${config.stateDir}/www/{data,config,logs}
            ln -sf ${pkgs.mattermost}/{bin,fonts,i18n,templates,client} ${config.stateDir}/www
            ln -sf ${cfgFile} ${config.stateDir}/www/config/config.json
          '';

          serviceConfig = {
            User = "mattermost";
            Group = "mattermost";
            Restart = "on-failure";
            WorkingDirectory = "${config.stateDir}/www";
            PrivateTmp = true;
            ExecStart = "${pkgs.mattermost}/bin/${mainBinary}";
            LimitNOFILE = "49152";
          };
        };

    tests.wanted = [ ./test.nix ];
  };
}
