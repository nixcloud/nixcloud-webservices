{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption types;
  inherit (config) defaultDatabaseType tempDbSetupHook;

  dbSpec = {
    postgresql = rec {
      socketPath = config.runtimeDir;
      phpHostname = socketPath;
    };

    mysql = rec {
      socketPath = "${config.runtimeDir}/.mysql.sock";
      phpHostname = "localhost:${socketPath}";
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

    options.tempDbSetupHook = mkOption {
      type = lib.mkOptionType {
        name = "setupHook";
        inherit (types.package) check;
      };
      readOnly = true;
      description = ''
        This is the final setup hook that can be used in derivations to
        temporarily spin up a database server for preinitializing databases and
        dumping them to an SQL file.
      '';
    };

    config.tempDbSetupHook = pkgs.makeSetupHook {
      name = "dump-from-temp-db";
      deps = tempDbSetupHook.dependencies;
      substitutions = {
        eatmydata = let
          soFile = "${pkgs.libeatmydata}/lib/libeatmydata.so";
        in "LD_PRELOAD=${lib.escapeShellArg soFile}";
      } // tempDbSetupHook.substitutions;
    } (pkgs.writeText "dump-from-temp-db.hook" ''
      export tempDbName=${lib.escapeShellArg config.name}
      export tempDbUser=${lib.escapeShellArg config.user}
      ${builtins.readFile tempDbSetupHook.script}
      postUnpackHooks+=(tempdbInit)
    '');
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

  options.tempDbSetupHook = {
    dependencies = mkOption {
      type = types.listOf types.package;
      internal = true;
      default = [];
      description = ''
        The dependencies that need to be available for the setup hook.
      '';
    };

    script = mkOption {
      type = types.path;
      internal = true;
      description = ''
        The path to the setup hook script, which automatically gets the
        following environment variables assigned on each run:

        <variablelist>
          <varlistentry>
            <term><envar>tempDbName</envar></term>
            <listitem><para>The temporary database name to
              create</para></listitem>
          </varlistentry>
          <varlistentry>
            <term><envar>tempDbUser</envar></term>
            <listitem><para>The temporary user name for creating/connecting to
              the database</para></listitem>
          </varlistentry>
        </variablelist>

        When using the setup hook in a derivation, the function
        <function>tempdbInit</function> is called after unpacking the source.

        In addition, the hook script <emphasis>must</emphasis> export the
        following environment variables to the build environment:

        <variablelist>
          <varlistentry>
            <term><envar>tempDbSocketPath</envar></term>
            <listitem><para>The path to the UNIX socket file</para></listitem>
          </varlistentry>
          <varlistentry>
            <term><envar>tempDbPhpHostname</envar></term>
            <listitem><para>A hostname for PHP connection strings to connect
              via UNIX socket file </para></listitem>
          </varlistentry>
        </variablelist>
      '';
    };

    substitutions = mkOption {
      type = types.attrsOf (types.either types.str types.package);
      internal = true;
      default = {};
      description = ''
        A mapping of keys and values, where <literal>@key@</literal> is then
        replaced by its value within the hook script.

        By default <literal>@eatmydata@</literal> is
        <emphasis>always</emphasis> available and can be prepended to commands
        that need to run without <citerefentry>
          <refentrytitle>fsync</refentrytitle>
          <manvolnum>2</manvolnum>
        </citerefentry>.
      '';
    };
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
    # Let's assume we have two databases, one is a PostgreSQL database called
    # "abc" and the second one is a MariaDB database "xyz". The following chart
    # illustrates the ordering of the targets/services during startup:
    #
    #                             network.target
    #                                   |
    #                                  \|/
    #                  .-------- db-server.target -------.
    #                  |                |                |
    #                 \|/               |                |
    #         mysql-initdb.service      |     postgresql-initdb.service
    #                  |                |                |
    #                 \|/               |               \|/
    #            mysql.service          |        postgresql.service
    #                  | |              |              | |
    #                  | `--------------|--------------' |
    #                  |                |                |
    #                 \|/               |               \|/
    #         database-abc.service      |       database-xyz.service
    #                  |                |                |
    #                 \|/               |               \|/
    #  database-abc-post-create.service | database-xyz-post-create.service
    #                  |                |                |
    #                  |               \|/               |
    #                  |--------- database.target -------|
    #                  |                |                |
    #                 \|/               |               \|/
    #          database-abc.target      |       database-xyz.target
    #                  |                |                |
    #                  `----------------|----------------'
    #                                   |
    #                                  \|/
    #                           multi-user.target
    #
    # Note that mysql.service/postgresql.service are NOT ordered before
    # database.target, so that we can ensure parallel creation of these
    # databases. For example if PostgreSQL is still starting up, MariaDB
    # databases will still be created in the meantime.
    systemd.targets = {
      db-server = {
        description = "Database Management Systems For ${config.uniqueName}";
        after = [ "network.target" ];
      };
      database = {
        description = "Databases For ${config.uniqueName}";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        instance.after = [ "db-server.target" ];
        instance.requires = [ "db-server.target" ];
      };
    } // lib.mapAttrs' (lib.const (dbcfg: {
      name = "database-${dbcfg.name}";
      value = {
        description = "Create Database ${dbcfg.name}";
        instance.requiredBy = [ "database.target" ];
        instance.after = [ "db-server.target" ];
        instance.before = [ "database.target" ];
      };
    })) config.database;
  };
}
