{ config, lib, ... }:

let
  inherit (lib) mkOption types;
  inherit (config) defaultDatabaseType;

  dbSpec = {
    postgresql = rec {
      socketPath = config.runtimeDir;
      phpHostname = socketPath;
    };

    mysql = rec {
      socketPath = "${config.runtimeDir}/.mysql.sock";
      phpHostname = ":${socketPath}";
    };
  };

  dbTypes = lib.attrNames dbSpec;

  dbSubmodule = { name, config, ... }: {
    options.type = mkOption {
      type = types.enum dbTypes;
      default = defaultDatabaseType;
      example = "mysql";
      description = ''
        The DBMS type to use for this database.

        <note><para>
        The default is dependant on the <option>defaultDatabaseType</option>.
        </para></note>
      '';
    };

    options.socketPath = mkOption {
      type = types.str;
      readOnly = true;
      default = dbSpec.${config.type}.socketPath;
      description = ''
        The path to the database socket file.
      '';
    };

    options.phpHostname = mkOption {
      type = types.str;
      readOnly = true;
      default = dbSpec.${config.type}.phpHostname;
      description = ''
        The hostname argument suitable for PHP.

        <note><para>This maps to the socket file rather than a real host
        name.</para></note>
      '';
    };

    options.name = mkOption {
      type = types.str;
      default = name;
      description = ''
        The name of the database or schema to create.
      '';
    };

    options.user = mkOption {
      type = types.str;
      default = name;
      description = ''
        The user name which should be the owner of the database.
      '';
    };

    options.postCreate = mkOption {
      type = types.lines;
      default = "";
      description = ''
        The commands to run shortly after the database has been created.

        <note><para>
        All of these commands are run in a context, where a special command
        called <command>sqlsh</command> is available, which in turn reads SQL
        commands from standard input and executes them on the current database.
        </para></note>
      '';
    };
  };

in {
  imports = map (dbtype: ./. + "/${dbtype}.nix") dbTypes;

  options.database = mkOption {
    type = types.attrsOf (types.submodule dbSubmodule);
    default = {};
    description = ''
      Map database names to their corresponding options.
    '';
  };

  options.dbShellCommand = mkOption {
    type = types.attrsOf types.str;
    example = {
      mysql = "exec mysql --user=\"$1\" --socket=/tmp/.mysql.sock \"$2\"";
    };
    internal = true;
    description = ''
      The attribute name is the specific database module and the attribute
      value is a shell script snippet which should connect to a database
      specified by its first argument using the user specified by the second
      argument.

      This option is only needed if you want to create your own database
      module.
    '';
  };

  options.defaultDatabaseType = mkOption {
    type = types.enum dbTypes;
    default = "postgresql";
    example = "mysql";
    description = ''
      The default type to use for all the databases where no explicit
      <option>type</option> has been defined.
    '';
  };

  config = lib.mkIf (config.enable && config.database != {}) {
    systemd.targets = {
      db-server = {
        description = "Database Management Systems For ${config.uniqueName}";
        after = [ "network.target" ];
        instance.requiredBy = [ "database.target" ];
      };
      database = {
        description = "Databases For ${config.uniqueName}";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
      };
    } // lib.mapAttrs' (lib.const (dbcfg: {
      name = "database-${dbcfg.name}";
      value = {
        description = "Create Database ${dbcfg.name}";
        instance.requiredBy = [ "database.target" ];
        instance.after = [ "db-server.target" ];
      };
    })) config.database;
  };
}
