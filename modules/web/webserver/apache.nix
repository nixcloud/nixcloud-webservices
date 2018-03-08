{ toplevel, config, pkgs, lib, options, wsName, mkUniqueUser, mkUniqueGroup
, apache, ...
}:

with lib;

{
  options.webserver.apache = {
    package = mkOption {
      type = types.package;
      default = pkgs.apacheHttpd;
      defaultText = "pkgs.apacheHttpd";
      description = ''
        Overridable attribute of the Apache HTTP Server package to use.
      '';
    };
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Cnfiguration lines appended to the generated Apache
        configuration file. 
      '';
    };
    extraModules = mkOption {
      type = types.listOf types.unspecified;
      default = [];
      example = literalExample ''[ "proxy_connect" { name = "php5"; path = "''${pkgs.php}/modules/libphp5.so"; } ]'';
      description = ''
        Additional Apache modules to be used.  These can be
        specified as a string in the case of modules distributed
        with Apache, or as an attribute set specifying the
        <varname>name</varname> and <varname>path</varname> of the
        module.
      '';
    };

    logPerVirtualHost = mkOption {
      type = types.bool;
      default = false;
      description = ''
        If enabled, each virtual host gets its own
        <filename>access_log</filename> and
        <filename>error_log</filename>, namely suffixed by the
        <option>hostName</option> of the virtual host.
      '';
    };

    logFormat = mkOption {
      type = types.str;
      default = "agent";
      description = ''
        Can be set to `combined`, `common`, `referer`, `agent` or `none`.
      ''; #'
    };

    enableMellon = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the mod_auth_mellon module.";
    };

    phpPackage = mkOption {
      type = types.package;
      default = pkgs.php;
      defaultText = "pkgs.php";
      description = ''
        Overridable attribute of the PHP package to use.
      '';
    };
    phpOptions = mkOption {
      type = types.lines;
      default = "";
      example =
        ''
          date.timezone = "CET"
        '';
      description =
        "Options appended to the PHP configuration file <filename>php.ini</filename>.";
    };
    multiProcessingModule = mkOption {
      type = types.str;
      default = "prefork";
      example = "worker";
      description =
        ''
          Multi-processing module to be used by Apache.  Available
          modules are <literal>prefork</literal> (the default;
          handles each request in a separate child process),
          <literal>worker</literal> (hybrid approach that starts a
          number of child processes each running a number of
          threads) and <literal>event</literal> (a recent variant of
          <literal>worker</literal> that handles persistent
          connections more efficiently).
        '';
    };
    maxClients = mkOption {
      type = types.int;
      default = 30;
      example = 8;
      description = "Maximum number of apache processes (prefork)";
    };
    maxRequestsPerChild = mkOption {
      type = types.int;
      default = 0;
      example = 500;
      description =
        "Maximum number of apache requests answered per apache child (prefork), 0 means unlimited";
    };
    adminAddr = mkOption {
      default = null;
      #type = types.str;
      description = "Email address of the admin/person responsible for this service.";
    };

    robotsEntries = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Lines to put into the <filename>robots.txt</filename> file.
      '';
    };
  };

  config = let
    httpd = config.webserver.apache.package.out;
    version24 = !versionOlder httpd.version "2.4";
  in mkIf (config.webserver.variant == "apache" && config.enable) {
    _module.args.apache = {
      allDenied = if version24 then ''
        Require all denied
      '' else ''
        Order deny,allow
        Deny from all
      '';

      allGranted = if version24 then ''
        Require all granted
      '' else ''
        Order allow,deny
        Allow from all
      '';
    };

    directories = lib.genAttrs [ "log" "runtime" ] (lib.const {
      permissions.defaultDirectoryMode = "0750";
      permissions.others.noAccess = true;
      owner = mkUniqueUser config.webserver.user;
      group = mkUniqueUser config.webserver.group;
      instance.before = [ "webserver-init.service" "instance-init.target" ];
    });

    webserver.init = ''
      #set -e
      #set +o pipefail

      # BUG: check if that code makes any sense
      # Get rid of old semaphores.  These tend to accumulate across
      # server restarts, eventually preventing it from restarting
      # successfully.
      for i in $(${pkgs.utillinux}/bin/ipcs -s | grep ' ${mkUniqueUser config.webserver.user} ' | cut -f2 -d ' '); do
          ${pkgs.utillinux}/bin/ipcrm -s $i
      done
    '';

    systemd.services.apache = let
      fileName = "${config.uniqueName}.conf";
      checkAndFormatApacheConfigfile = (import lib/apache_check_config.nix {inherit lib pkgs;}).checkAndFormatApacheConfigfile {
        configFile = apacheConfigFile;
        inherit fileName;
      };

      apacheConfigFile = pkgs.writeText fileName ''
        ServerRoot ${httpd}

        ${optionalString version24 ''
          DefaultRuntimeDir ${config.stateDir}/runtime
        ''}

        PidFile ${config.runtimeDir}/apache.pid

        ${optionalString (config.webserver.apache.multiProcessingModule != "prefork") ''
          # mod_cgid requires this.
          ScriptSock ${config.runtimeDir}/cgisock
        ''}

        <IfModule prefork.c>
            MaxClients           ${toString config.webserver.apache.maxClients}
            MaxRequestsPerChild  ${toString config.webserver.apache.maxRequestsPerChild}
        </IfModule>

        Listen *:${toString config.proxyOptions.port}
        #Listen unix:/var/run/nginx.sock

        User ${mkUniqueUser config.webserver.user}
        Group ${mkUniqueGroup config.webserver.group}

        ${let
            load = {name, path}: "LoadModule ${name}_module ${path}\n";
            allModules = []
              ++ map (name: {inherit name; path = "${httpd}/modules/mod_${name}.so";}) apacheModules
              ++ optional config.webserver.apache.enableMellon { name = "auth_mellon"; path = "${pkgs.apacheHttpdPackages.mod_auth_mellon}/modules/mod_auth_mellon.so"; }
              ++ optional config.webserver.enablePHP { name = "php${phpMajorVersion}"; path = "${php}/modules/libphp${phpMajorVersion}.so"; }
              ++ extraForeignModules
              ++ config.webserver.apache.extraModules;
          in concatMapStrings load allModules
        }

        AddHandler type-map var

        <Files ~ "^\.ht">
          ${apache.allDenied}
        </Files>

        ${mimeConf}
        ${loggingConf}
        ${browserHacks}

        Include ${httpd}/conf/extra/httpd-default.conf
        Include ${httpd}/conf/extra/httpd-autoindex.conf
        Include ${httpd}/conf/extra/httpd-multilang-errordoc.conf
        Include ${httpd}/conf/extra/httpd-languages.conf

        ${if config.webserver.apache.adminAddr != null then ''
          ServerAdmin ${config.webserver.apache.adminAddr}
        '' else ""}

        # Fascist default - deny access to everything.
        <Directory />
          Options FollowSymLinks
          AllowOverride None
          ${apache.allDenied}
        </Directory>

        # But do allow access to files in the store so that we don't have
        # to generate <Directory> clauses for every generated file that we
        # want to serve.
        <Directory /nix/store>
          ${apache.allGranted}
        </Directory>

        ServerName "${config.uniqueName}"

        ${optionalString (robotsTxt != "") ''
          Alias /robots.txt ${pkgs.writeText "robots.txt" robotsTxt}
        ''}

        ${config.webserver.apache.extraConfig}
      '';

      robotsTxt = config.webserver.apache.robotsEntries;

      php = config.webserver.apache.phpPackage.override { apacheHttpd = httpd.dev; /* otherwise it only gets .out */ };
      phpMajorVersion = head (splitString "." php.version);

      phpOptions = ''
        ; Needed for PHP's mail() function.
        sendmail_path = sendmail -t -i

        ${optionalString (toplevel.config.time.timeZone != null) ''
          date.timezone = "${toplevel.config.time.timeZone}"
        ''}
      '';

      # FIXME: assumption is that none of these work, should probably be config.webserver
      extraForeignModules = filter isAttrs config.webserver.apache.extraModules;
      extraApacheModules = filter isString config.webserver.apache.extraModules;

      # !!! should be in lib
      writeTextInDir = name: text:
        pkgs.runCommand name {inherit text;} "mkdir -p $out; echo -n \"$text\" > $out/$name";

      # Names of modules from ${httpd}/modules that we want to load.
      apacheModules =
        [ # HTTP authentication mechanisms: basic and digest.
          "auth_basic" "auth_digest"

          # Authentication: is the user who he claims to be?
          "authn_file" "authn_dbm" "authn_anon"
          (if version24 then "authn_core" else "authn_alias")

          # Authorization: is the user allowed access?
          "authz_user" "authz_groupfile" "authz_host"

          # Other modules.
          "ext_filter" "include" "log_config" "env" "mime_magic"
          "cern_meta" "expires" "headers" "usertrack" /* "unique_id" */ "setenvif"
          "mime" "dav" "status" "autoindex" "asis" "info" "dav_fs"
          "vhost_alias" "negotiation" "dir" "imagemap" "actions" "speling"
          "userdir" "alias" "rewrite" "proxy" "proxy_http"
        ]
        ++ optionals version24 [
          "mpm_${config.webserver.apache.multiProcessingModule}"
          "authz_core"
          "unixd"
          "cache" "cache_disk"
          "slotmem_shm"
          "socache_shmcb"
          # For compatibility with old configurations, the new module mod_access_compat is provided.
          "access_compat"
        ]
        ++ (if config.webserver.apache.multiProcessingModule == "prefork" then [ "cgi" ] else [ "cgid" ])
        ++ extraApacheModules;

      loggingConf = (if config.webserver.apache.logFormat != "none" then ''
        ErrorLog ${config.stateDir}/log/error_log

        LogLevel notice

        LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
        LogFormat "%h %l %u %t \"%r\" %>s %b" common
        LogFormat "%{Referer}i -> %U" referer
        LogFormat "%{User-agent}i" agent

        CustomLog ${config.stateDir}/log/access_log ${config.webserver.apache.logFormat}
      '' else ''
        ErrorLog /dev/null
      '');

      browserHacks = ''
        BrowserMatch "Mozilla/2" nokeepalive
        BrowserMatch "MSIE 4\.0b2;" nokeepalive downgrade-1.0 force-response-1.0
        BrowserMatch "RealPlayer 4\.0" force-response-1.0
        BrowserMatch "Java/1\.0" force-response-1.0
        BrowserMatch "JDK/1\.0" force-response-1.0
        BrowserMatch "Microsoft Data Access Internet Publishing Provider" redirect-carefully
        BrowserMatch "^WebDrive" redirect-carefully
        BrowserMatch "^WebDAVFS/1.[012]" redirect-carefully
        BrowserMatch "^gnome-vfs" redirect-carefully
      '';

      mimeConf = ''
        TypesConfig ${httpd}/conf/mime.types

        AddType application/x-x509-ca-cert .crt
        AddType application/x-pkcs7-crl    .crl
        AddType application/x-httpd-php    .php .phtml

        <IfModule mod_mime_magic.c>
            MIMEMagicFile ${httpd}/conf/magic
        </IfModule>
      '';

      # Generate the PHP configuration file.  Should probably be factored
      # out into a separate module.
      phpIni = let
        # PHP versions below 7.2 are bundled with PCRE versions below 8.41 and
        # thus almost all of the preg_* functions will most likely not match
        # when the JIT compiler is enabled.
        #
        # The reason for this is that PCRE 8.41 has changed the stack layout to
        # a top-down stack and for some reason I haven't figured out yet the
        # stack gets shared between the Apache SAPI and PHP's bundled module.
        disablePcreJit = ''
          echo "pcre.jit=0" >> "$out"
        '';

        contents = ''
          cat ${php}/etc/php.ini > $out
          echo "$options" >> $out
        '' + optionalString (versionOlder php.version "7.2") disablePcreJit;

      in pkgs.runCommand "php.ini" {
        options = concatStringsSep "\n" [
          phpOptions config.webserver.apache.phpOptions
        ];
      } contents;
    in {
      description = "${config.uniqueName} main service (Apache HTTPD)";
      wantedBy = [ "multi-user.target" ];
      wants = [ "keys.target" ];
      after = [ "network.target" "fs.target" "keys.target" ];
      instance.after = [ "database.target" "webserver-init.service" ];

      path =
        [ config.webserver.apache.package.out pkgs.coreutils pkgs.gnugrep ]
        ++ # Needed for PHP's mail() function.  !!! Probably the
            # ssmtp module should export the path to sendmail in
            # some way.
            optional toplevel.config.networking.defaultMailServer.directDelivery pkgs.ssmtp;

      environment =
        optionalAttrs config.webserver.enablePHP { PHPRC = phpIni; }
        // optionalAttrs config.webserver.apache.enableMellon { LD_LIBRARY_PATH  = "${pkgs.xmlsec}/lib"; };

      serviceConfig = {
        ExecStart = "@${httpd}/bin/httpd httpd -f ${checkAndFormatApacheConfigfile}/${fileName}";
        ExecStop = "${httpd}/bin/httpd -f ${checkAndFormatApacheConfigfile}/${fileName} -k graceful-stop";
        ExecReload = "${httpd}/bin/httpd -f ${checkAndFormatApacheConfigfile}/${fileName} -k graceful";
        Type = "forking";
        PIDFile = "${config.runtimeDir}/apache.pid";
        Restart = "always";
        RestartSec = "5s";
        User = config.webserver.user;
        Group = config.webserver.group;
        PermissionsStartOnly = true;
        PrivateTmp = config.webserver.privateTmp;
      };
    };
  };
}
