{ lib, mkUniqueUser, mkUniqueGroup, pkgs, config, ... }:

let
  filterDb = lib.const (db: db.type == "mysql");
  dbs = lib.filterAttrs filterDb config.database;

  inherit (config.mysql) package dataDir;
  isMariaDb = lib.hasPrefix "mariadb" package.name;
  serverName = if isMariaDb then "MariaDB" else "MySQL";
  progName = if isMariaDb then "mariadb" else "mysql";
  authMethod = if isMariaDb then "unix_socket" else "auth_socket";

  escapeSql = val: "'${lib.escape ["'" "\\"] val}'";
  assertSqlIdent = v: assert builtins.match "[0-9a-zA-Z$_]+" v != null; v;

  mysqlShell = user: database: let
    prog = "${package}/bin/mysql";
    args = [
      "--user=${user}"
      "--socket=${configuration.socket}"
      database
    ];
  in "${prog} " + lib.concatMapStringsSep " " lib.escapeShellArg args;

  dbservices = lib.listToAttrs (lib.concatMap (cfg: let
    mainUser = mkUniqueUser cfg.user;
    owners = lib.singleton mainUser ++ map mkUniqueUser cfg.owners;
    mkStateFile = action: let
      filename = ".database-${action}-${cfg.name}";
    in "${config.stateDir}/${filename}";
  in [
    { name = "database-${cfg.name}";
      value = {
        instance.requiredBy = [ "database-${cfg.name}.target" ];
        instance.before = [ "database-${cfg.name}.target" ];
        instance.after = [ "mysql.service" ];
        script = let
          createDb = pkgs.writeText "create-${cfg.name}.sql" ''
            CREATE DATABASE `${assertSqlIdent cfg.name}`;
            ${lib.concatMapStrings (uname: ''
              CREATE USER IF NOT EXISTS ${escapeSql uname}@'localhost'
                IDENTIFIED WITH ${authMethod};
              GRANT ALL ON `${assertSqlIdent cfg.name}`.* TO
                ${escapeSql uname}@'localhost';
            '') owners}
          '';
        in "${mysqlShell (mkUniqueUser "mysql") "mysql"} < ${createDb}";
        postStart = "touch ${lib.escapeShellArg (mkStateFile "create")}";
        unitConfig.ConditionPathExists = "!${mkStateFile "create"}";
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          PermissionsStartOnly = true;
          User = "mysql";
          Group = "mysql";
        };
      };
    }
    { name = "database-${cfg.name}-post-create";
      value = {
        instance.requiredBy = [ "database-${cfg.name}.target" ];
        instance.before = [ "database-${cfg.name}.target" ];
        instance.after = [
          "mysql.service"
          "database-${cfg.name}.service"
        ];
        script = cfg.postCreate;
        path = lib.singleton (pkgs.writeScriptBin "sqlsh" ''
          #!${pkgs.stdenv.shell}
          exec ${mysqlShell (mkUniqueUser cfg.user) cfg.name} "$@"
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

  configuration = {
    basedir = package;
    datadir = dataDir;
    log-output = "NONE";
    skip-networking = true;
    socket = "${config.runtimeDir}/.mysql.sock";
    plugin-load-add = "auth_socket.so";
  };

  cfgVals = let
    mkCfgVal = name: val: let
      flag = "--${name}" + lib.optionalString (val != true) "=${val}";
    in lib.escapeShellArg flag;
  in lib.mapAttrsToList mkCfgVal configuration;

  cmdLine = lib.concatStringsSep " " cfgVals;

in {
  options.mysql = {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.mariadb;
      example = lib.literalExample "pkgs.mysql57";
      description = "MySQL package to use.";
    };

    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "${config.stateDir}/mysql";
      readOnly = true;
      description = "Data directory for MySQL";
    };
  };

  config = lib.mkIf (dbs != {} && config.enable) {
    users.mysql = {
      group = "mysql";
      description = "${serverName} Server User";
    };

    groups.mysql = {};

    dbShellCommand.mysql = ''
      exec ${lib.escapeShellArg "${package}/bin/mysql"} \
        --user="$1" \
        --socket=${lib.escapeShellArg configuration.socket} \
        "$2"
    '';

    tempDbSetupHook.dependencies = [ package ];
    tempDbSetupHook.script = ./mysql-hook.sh;
    tempDbSetupHook.substitutions.mysqlBaseDir = package;

    directories.mysql = {
      instance.before = [ "mysql-initdb.service" ];
      permissions.defaultDirectoryMode = "0711";
      permissions.group.noAccess = true;
      permissions.others.noAccess = true;
      permissions.enableACLs = false;
      owner = mkUniqueUser "mysql";
      group = mkUniqueGroup "mysql";
    };

    systemd.services = {
      mysql-initdb = {
        description = "Initialize ${serverName} Server";
        instance.requiredBy = [ "mysql.service" ];
        instance.before = [ "mysql.service" ];
        unitConfig.ConditionPathExists = "!${dataDir}/mysql";
        serviceConfig = {
          ExecStart = "${package}/bin/mysql_install_db ${cmdLine}";
          Type = "oneshot";
          RemainAfterExit = true;
          PermissionsStartOnly = true;
          User = "mysql";
          Group = "mysql";
        };
      };

      mysql = {
        description = "${serverName} Server";
        instance.requiredBy = [ "db-server.target" ];
        instance.before = [ "db-server.target" ];
        after = [ "network.target" ];
        postStart = let
          superuser = escapeSql (mkUniqueUser "mysql");
          dropRoot = pkgs.writeText "drop-root.sql" ''
            CREATE USER ${superuser}@'localhost' IDENTIFIED WITH ${authMethod};
            GRANT ALL ON *.* TO ${superuser}@'localhost' WITH GRANT OPTION;
            DROP DATABASE test;
            DELETE FROM mysql.user WHERE user IN ('root', ''');
            FLUSH PRIVILEGES;
          '';
        in ''
          if [ ! -e ${lib.escapeShellArg dataDir}/.root-dropped ]; then
            ${mysqlShell "root" "mysql"} < ${dropRoot}
            touch ${lib.escapeShellArg dataDir}/.root-dropped
          fi
        '';
        serviceConfig = {
          ExecStart = "@${package}/bin/mysqld ${progName} ${cmdLine}";
          User = "mysql";
          Group = "mysql";
          Type = "notify";
        };
      };
    } // dbservices;
  };
}
