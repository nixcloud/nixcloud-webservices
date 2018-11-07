{ lib, mkUnique, mkUniqueUser, mkUniqueGroup, nclib, pkgs, config, ... }:

let
  inherit (config.messaging.rabbitmq) package dataDir;

  epmdRules = [
    { port = 4369;
      type = "tcp";
      direction = "outgoing";
      socketPath = "${config.runtimeDir}/epmd.socket";
    }
    # This rule is to make sure that the process is not starting another epmd
    # and instead usees the one provided by the systemd service.
    { port = 4369;
      type = "tcp";
      direction = "incoming";
      reject = true;
      rejectError = "EADDRINUSE";
    }
    { port = 0;
      socketPath = "${config.runtimeDir}/.epmd-rabbitmq-%p.socket";
    }
    { socketPath = "/tmp/xxx-%a-%t-%p.socket"; }
  ];

  rabbitmqEnvFile = let
    mkEnvVar = name: val: "${name}=${lib.escapeShellArg val}";
    mkEnvVars = lib.mapAttrsToList mkEnvVar;
    mkEnvConf = attrs: lib.concatStringsSep "\n" (mkEnvVars attrs) + "\n";
  in pkgs.writeText "rabbitmq-env.sh" (mkEnvConf {
    CONFIG_FILE = let
      rabbit37 = lib.versionAtLeast package.version "3.7.0";
      oldConfig = pkgs.writeText "rabbitmq.config" ''
        [{rabbit, [{loopback_users, []}]}].
      '';
    in if rabbit37 then pkgs.writeText "rabbitmq.conf" ''
      loopback_users = none
    '' else lib.removeSuffix ".config" oldConfig;
    LOG_BASE = "${dataDir}/log";
    MNESIA_BASE = "${dataDir}/mnesia";
    ENABLED_PLUGINS_FILE = pkgs.writeText "rabbitmq-enabled-plugins" "";
    GENERATED_CONFIG_DIR = "${dataDir}/config";
    SCHEMA_DIR = "${dataDir}/schema";
    SERVER_ADDITIONAL_ERL_ARGS = "-setcookie NOT_NEEDED";
    CTL_ERL_ARGS = "-setcookie NOT_NEEDED";
  });

  wrappedCtl = nclib.ip2unix {
    program = "${package}/bin/rabbitmqctl";
    baseName = mkUnique "rabbitmqctl";
    makeWrapperArgs = [
      "--set" "RABBITMQ_CONF_ENV_FILE" (toString rabbitmqEnvFile)
    ];
    useBinDir = true;
    rules = [
      { port = 25672;
        type = "tcp";
        direction = "outgoing";
        socketPath = "${config.runtimeDir}/rabbitmqctl.socket";
      }
      { port = 35672;
        portEnd = 35682;
        direction = "incoming";
        socketPath = "${config.runtimeDir}/rabbitmqctl-%p.socket";
      }
    ] ++ epmdRules;
  };

in {
  options.messaging.rabbitmq = {
    enable = lib.mkEnableOption "RabbitMQ AMQP broker";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.rabbitmq_server or pkgs.rabbitmq-server;
      example = lib.literalExample "pkgs.rabbitmq-server";
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

    tools.useRabbitMQ = nclib.ip2unix {
      baseName = "rabbitmq-client";
      rules = lib.singleton {
        port = 5672;
        type = "tcp";
        direction = "outgoing";
        socketPath = "${config.runtimeDir}/rabbitmq.socket";
      };
    };

    groups.rabbitmq = {};

    directories.rabbitmq = {
      instance.before = [ "rabbitmq.service" "epmd.socket" ];
      permissions.defaultDirectoryMode = "0711";
      permissions.group.noAccess = true;
      permissions.others.noAccess = true;
      permissions.enableACLs = false;
      owner = mkUniqueUser "rabbitmq";
      group = mkUniqueGroup "rabbitmq";
    };

    # TODO: Move into own module once we have more Erlang services.
    systemd.sockets.epmd = {
      description = "Erlang Port Mapper Daemon Socket";
      instance.requiredBy = [ "instance-init.target" ];
      unitConfig.DefaultDependencies = false;
      socketConfig.ListenStream = "${config.runtimeDir}/epmd.socket";
      socketConfig.FileDescriptorName = "epmd";
    };

    systemd.services.epmd = {
      description = "Erlang Port Mapper Daemon";
      # While epmd has the ability to use systemd socket activation, we instead
      # use the one by ip2unix, because the implementation of epmd expects IP
      # sockets.
      serviceConfig.ExecStart = "${nclib.ip2unix {
        program = "${pkgs.erlang}/bin/epmd";
        rules = [
          { port = 4369;
            type = "tcp";
            address = "127.0.0.1";
            direction = "incoming";
            socketActivation = true;
            fdName = "epmd";
          }
          { direction = "incoming";
            blackhole = true;
          }
          # Needed for epmd to check whether the node is alive.
          #{ direction = "outgoing";
          #  socketPath = "${config.runtimeDir}/.epmd-rabbitmq-%p.socket";
          #}
        ];
      }} -address 127.0.0.1";
      serviceConfig.DynamicUser = true;
    };

    systemd.services.rabbitmq = {
      description = "RabbitMQ Server";
      instance.requiredBy = [ "instance-init.target" ];

      # Needed for startup notifications
      path = [ pkgs.socat ];

      environment.RABBITMQ_CONF_ENV_FILE = rabbitmqEnvFile;

      serviceConfig = {
        ExecStart = nclib.ip2unix {
          program = "${package}/bin/rabbitmq-server";
          rules = [
            { port = 5671;
              portEnd = 5672;
              type = "tcp";
              direction = "incoming";
              socketPath = "${config.runtimeDir}/rabbitmq.socket";
            }
            { type = "tcp";
              port = 25672;
              direction = "incoming";
              socketPath = "${config.runtimeDir}/rabbitmqctl.socket";
            }
            { port = 35672;
              portEnd = 35682;
              direction = "outgoing";
              socketPath = "${config.runtimeDir}/rabbitmqctl-%p.socket";
            }
          ] ++ epmdRules;
        };
        ExecStop = lib.escapeShellArgs [
          "${wrappedCtl}/bin/${mkUnique "rabbitmqctl"}" "stop"
        ];
        User = "rabbitmq";
        Group = "rabbitmq";
        Type = "notify";
        NotifyAccess = "all";
      };
    };

    tests.wanted = [ ./test.nix ];

    # FIXME: This shouldn't be "webserver." and we need a generic way to pass
    # through helper programs.
    webserver.systemPackages = [ wrappedCtl ];
  };
}
