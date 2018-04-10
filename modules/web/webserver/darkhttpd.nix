{ config, pkgs, lib, options, wsName, mkUniqueUser, mkUniqueGroup, ... }:

with lib;

let
  enabled = config.webserver.variant == "darkhttpd" && config.enable;
  isDefaultRoot = config.webserver.darkhttpd.root == "${config.stateDir}/www";
in {
  options.webserver.darkhttpd = {
    root = mkOption {
      type = types.path;
      default = "${config.stateDir}/www";
      example = /var/www/whatever;
      description = "The directory where the static webserver looks for documents to serve.";
    };
    extraServiceDependencies = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [ "postgresql.service" ];
      description = "Makes it easy to replace postgresql by mysql and depend on the service before we start the webservice.";
    };
  };

  config = lib.mkMerge [
    (mkIf (enabled && isDefaultRoot) {
      directories.www = {
        owner = mkUniqueUser config.webserver.user;
        group = mkUniqueGroup config.webserver.group;
        instance.before = [ "webserver-init.service" "instance-init.target" ];
      };
    })
    (mkIf enabled {
      directories.log = {
        permissions.defaultDirectoryMode = "0750";
        permissions.others.noAccess = true;
        owner = mkUniqueUser config.webserver.user;
        group = mkUniqueGroup config.webserver.group;
        instance.before = [ "webserver-init.service" "instance-init.target" ];
      };

      systemd.services.darkhttpd = {
        description = "${config.uniqueName} main service (darkhttpd)";
        wantedBy = [ "multi-user.target" ];
        wants = [ "keys.target" ];
        after = [ "network.target" "fs.target" "keys.target" ];
        instance.after = [ "database.target" "webserver-init.service" ];

        serviceConfig = {
          ExecStart = "${pkgs.darkhttpd}/bin/darkhttpd ${toString config.root} --port ${toString config.proxyOptions.port} --addr 127.0.0.1";
          KillSignal = "SIGTERM";
          Restart = "always";
          RestartSec = "10s";
          StartLimitInterval = "1min";
          User = config.webserver.user;
          Group = config.webserver.group;
          PermissionsStartOnly = true;
          PrivateTmp = config.webserver.privateTmp;
          WorkingDirectory = config.stateDir;
          MemoryDenyWriteExecute = true;
          RestrictNameSpaces = true;
          NoNewPrivileges = true;
          ProtectHome = true;
          PrivateUsers = true;
          ProtectSystem = true;
          ProtectKernelTunables = true;
        };
      };
    })
  ];
}
