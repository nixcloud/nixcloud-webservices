{ lib, mkUniqueUser, mkUniqueGroup, pkgs, config, ... }:

let
  filterDb = lib.const (db: db.type == "postgresql");
  dbs = lib.filterAttrs filterDb config.database;

  package = config.postgresql.package.overrideAttrs (drv: {
    configureFlags = (drv.configureFlags or []) ++ [ "--with-systemd" ];
    buildInputs = (drv.buildInputs or []) ++ [ pkgs.systemd ];
  });

  dbservices = lib.listToAttrs (lib.concatMap (cfg: let
    dbuser = mkUniqueUser cfg.user;
    mkStateFile = action: let
      filename = ".database-${action}-${cfg.name}";
    in "${config.stateDir}/${filename}";
  in [
    { name = "database-${cfg.name}";
      value = {
        instance.requiredBy = [ "database-${cfg.name}.target" ];
        instance.before = [ "database-${cfg.name}.target" ];
        instance.after = [ "postgresql.service" ];
        environment.PGHOST = cfg.socketPath;
        script = ''
          ${package}/bin/createuser ${lib.escapeShellArg dbuser}
          ${package}/bin/createdb ${lib.escapeShellArg cfg.name} \
            -O ${lib.escapeShellArg dbuser}
        '';
        postStart = "touch ${lib.escapeShellArg (mkStateFile "create")}";
        unitConfig.ConditionPathExists = "!${mkStateFile "create"}";
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          PermissionsStartOnly = true;
          User = "postgres";
          Group = "postgres";
        };
      };
    }
    { name = "database-${cfg.name}-post-create";
      value = {
        instance.requiredBy = [ "database-${cfg.name}.target" ];
        instance.before = [ "database-${cfg.name}.target" ];
        instance.after = [
          "postgresql.service"
          "database-${cfg.name}.service"
        ];
        environment.PGHOST = cfg.socketPath;
        script = cfg.postCreate;
        path = lib.singleton (pkgs.writeScriptBin "sqlsh" ''
          #!${pkgs.stdenv.shell}
          exec ${package}/bin/psql ${lib.escapeShellArg cfg.name} "$@"
        '');
        postStart = "touch ${lib.escapeShellArg (mkStateFile "post-create")}";
        unitConfig.ConditionPathExists = "!${mkStateFile "post-create"}";
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          PermissionsStartOnly = true;
          User = cfg.user;
        };
      };
    }
  ]) (lib.attrValues dbs));

  inherit (config.postgresql) dataDir;
  inherit (package) psqlSchema;

  configuration = {
    hba_file = pkgs.writeText "pg_hba.conf" ''
      local all all peer
    '';
    unix_socket_directories = config.runtimeDir;
    log_destination = "stderr";
    port = "5432";
    listen_addresses = "";
  };

in {
  options.postgresql = {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.postgresql96;
      example = lib.literalExample "pkgs.postgresql96";
      description = "PostgreSQL package to use.";
    };

    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "${config.stateDir}/postgresql/${psqlSchema}";
      readOnly = true;
      description = "Data directory for PostgreSQL";
    };
  };

  config = lib.mkIf (dbs != {} && config.enable) {
    users.postgres = {
      group = "postgres";
      description = "PostgreSQL Server User";
    };

    groups.postgres = {};

    dbShellCommand.postgresql = ''
      export PGHOST=${lib.escapeShellArg config.runtimeDir}
      exec ${lib.escapeShellArg "${package}/bin/psql"} "$2"
    '';

    directories."postgresql/${psqlSchema}" = {
      instance.before = [ "postgresql-initdb.service" ];
      permissions.defaultDirectoryMode = "0711";
      permissions.group.noAccess = true;
      permissions.others.noAccess = true;
      owner = mkUniqueUser "postgres";
      group = mkUniqueGroup "postgres";
    };

    systemd.services = {
      postgresql-initdb = {
        description = "Initialize PostgreSQL Cluster";
        instance.requiredBy = [ "postgresql.service" ];
        instance.before = [ "postgresql.service" ];
        environment.PGDATA = dataDir;
        unitConfig.ConditionPathExists = "!${dataDir}/PG_VERSION";
        serviceConfig = {
          ExecStart = "${package}/bin/initdb";
          Type = "oneshot";
          RemainAfterExit = true;
          PermissionsStartOnly = true;
          User = "postgres";
          Group = "postgres";
        };
      };

      postgresql = {
        description = "PostgreSQL Server";
        instance.requiredBy = [ "db-server.target" ];
        instance.before = [ "db-server.target" ];
        after = [ "network.target" ];
        environment.PGDATA = dataDir;
        serviceConfig = {
          ExecStart = let
            mkCfgVal = name: val: "-c ${lib.escapeShellArg "${name}=${val}"}";
            cfgVals = lib.mapAttrsToList mkCfgVal configuration;
          in "${package}/bin/postgres ${lib.concatStringsSep " " cfgVals}";
          User = "postgres";
          Group = "postgres";
          Type = "notify";
        };
      };
    } // dbservices;
  };
}
