{ lib, mkUniqueUser, mkUniqueGroup, nclib, pkgs, config, ... }:

let
  inherit (config.messaging.rabbitmq) package dataDir;

  wrappedServer = nclib.ipToUnix {
    program = "${package}/bin/rabbitmq-server";
    rules = [
      { port = 4369;
        type = "udp";
        socketPath = "${config.runtimeDir}/epmd-udp.socket";
      }
      { port = 4369;
        type = "tcp";
        socketPath = "${config.runtimeDir}/epmd-tcp.socket";
      }
      { type = "udp";
        port = 5672;
        socketPath = "${config.runtimeDir}/rabbitmq-udp.socket";
      }
      { type = "tcp";
        port = 5672;
        socketPath = "${config.runtimeDir}/rabbitmq-tcp.socket";
      }
    ];
  };

  wrappedCtl = nclib.ipToUnix {
    program = "${package}/bin/rabbitmqctl";
    useBinDir = true;
    rules = lib.singleton {
      direction = "outgoing";
      socketPath = "${config.runtimeDir}/rabbitmq.socket";
    };
  };

in {
  options.messaging.rabbitmq = {
    enable = lib.mkEnableOption "RabbitMQ AMQP broker";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.rabbitmq_server;
      example = lib.literalExample "pkgs.rabbitmq_server";
      description = "RabbitMQ package to use.";
    };

    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "${config.stateDir}/rabbitmq";
      readOnly = true;
      description = "Data directory for RabbitMQ.";
    };
  };

  config = lib.mkIf (config.enable && config.messaging.rabbitmq.enable) {
    users.rabbitmq = {
      group = "rabbitmq";
      description = "RabbitMQ User";
      home = dataDir;
      createHome = true;
    };

    groups.rabbitmq = {};

    directories.rabbitmq = {
      instance.before = [ "rabbitmq.service" ];
      permissions.defaultDirectoryMode = "0711";
      permissions.group.noAccess = true;
      permissions.others.noAccess = true;
      permissions.enableACLs = false;
      owner = mkUniqueUser "rabbitmq";
      group = mkUniqueGroup "rabbitmq";
    };

    systemd.services.rabbitmq = {
      description = "RabbitMQ Server";
      instance.requiredBy = [ "instance-init.target" ];
      after = [ "network.target" ];

      # Needed for startup notifications
      path = [ pkgs.socat ];

      environment.RABBITMQ_CONF_ENV_FILE = let
        mkEnvVar = name: val: "${name}=${lib.escapeShellArg val}";
        mkEnvVars = lib.mapAttrsToList mkEnvVar;
        mkEnvConf = attrs: lib.concatStringsSep "\n" (mkEnvVars attrs) + "\n";
      in pkgs.writeText "rabbitmq-env.sh" (mkEnvConf {
        CONFIG_FILE = pkgs.writeText "rabbitmq.conf" ''
        '';
        LOG_BASE = "${dataDir}/log";
        MNESIA_BASE = "${dataDir}/mnesia";
        ENABLED_PLUGINS_FILE = pkgs.writeText "rabbitmq-enabled-plugis" "";
        GENERATED_CONFIG_DIR = "${dataDir}/config";
        ADVANCED_CONFIG_FILE = pkgs.writeText "rabbitmq-advanced.erl" ''
        '';
        SCHEMA_DIR = "${dataDir}/schema";
      });

      serviceConfig = {
        #ExecStart = "@${wrappedServer} rabbitmq --help";
        ExecStart = "${pkgs.strace}/bin/strace -f -e trace=network ${wrappedServer}";
        ExecStop = "${wrappedCtl}/bin/rabbitmqctl stop";
        User = "rabbitmq";
        Group = "rabbitmq";
        Type = "notify";
        NotifyAccess = "all";
      };
    };

    tests.wanted = [ ./test.nix ];
  };
}
