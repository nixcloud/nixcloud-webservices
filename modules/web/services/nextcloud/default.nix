{ config, options, lib, pkgs, wsName, ... }:

#
# WARNING: this is WIP and it is an early stage of development
#           qknight
#

with lib;
{
  options = {

    adminUser = mkOption {
      default = "nextcloud";
      description = "The admin user name for accessing nextcloud.";
    };

    adminPassword = mkOption {
      description = "The admin password for accessing nextcloud.";
    };

    dbType = mkOption {
      default = "pgsql";
      description = "Type of database, in NixOS, for now, only pgsql.";
    };

    dbName = mkOption {
      default = "nextcloud";
      description = "Name of the database that holds the nextcloud data.";
    };

    dbServer = mkOption {
      default = "localhost:5432";
      description = ''
        The location of the database server.
      '';
    };

    dbUser = mkOption {
      default = "nextcloud";
      description = "The user name for accessing the database.";
    };

    dbPassword = mkOption {
      example = "foobar";
      description = ''
        The password of the database user.  Warning: this is stored in
        cleartext in the Nix store!
      '';
    };

    forceSSL = mkOption {
      default = "false";
      description = "Force use of HTTPS connection.";
    };

    adminAddr = mkOption {
      default = serverInfo.serverConfig.adminAddr;
      example = "admin@example.com";
      description = ''
        Emergency contact e-mail address.  Defaults to the Apache
        admin address.
      '';
    };

    siteName = mkOption {
      default = "nextcloud";
      example = "Foobar nextcloud";
      description = "Name of the nextcloud";
    };

    trustedDomain = mkOption {
      default = "";
      description = "Trusted domain";
    };

    defaultLang = mkOption {
      default = "";
      description = "Default language";
    };

    defaultApp = mkOption {
      default = "";
      description = "Default application";
    };

    appStoreEnable = mkOption {
      default = "true";
      description = "Enable app store";
    };

    mailFrom = mkOption {
      default = "no-reply";
      description = "Mail from";
    };

    mailFromDomain = mkOption {
      default = "example.xyz";
      description = "Mail from domain";
    };

    SMTPMode = mkOption {
      default = "smtp";
      description = "Which mode to use for sending mail: sendmail, smtp, qmail or php.";
    };

    SMTPHost = mkOption {
      default = "";
      description = "SMTP host";
    };

    SMTPPort = mkOption {
      default = "25";
      description = "SMTP port";
    };

    SMTPTimeout = mkOption {
      default = "10";
      description = "SMTP mode";
    };

    SMTPSecure = mkOption {
      default = "ssl";
      description = "SMTP secure";
    };

    SMTPAuth = mkOption {
      default = "true";
      description = "SMTP auth";
    };

    SMTPAuthType = mkOption {
      default = "LOGIN";
      description = "SMTP auth type";
    };

    SMTPUser = mkOption {
      default = "";
      description = "SMTP user";
    };

    SMTPPass = mkOption {
      default = "";
      description = "SMTP pass";
    };

    dataDir = mkOption { # FIXME: broken path, needs proper testing
      default = "${config.stateDir}";
      description = "Data dir";
    };

    libreofficePath = mkOption {
      default = "/usr/bin/libreoffice";
      description = "Path for LibreOffice/OpenOffice binary.";
    };

    overwriteHost = mkOption {
      default = "";
      description = "The automatic hostname detection of ownCloud can fail in
        certain reverse proxy and CLI/cron situations. This option allows to
        manually override the automatic detection. You can also add a port.";
    };

    overwriteProtocol = mkOption {
      default = "";
      description = "The automatic protocol detection of ownCloud can fail in
        certain reverse proxy and CLI/cron situations. This option allows to
        manually override the protocol detection.";
    };

    overwriteWebRoot = mkOption {
      default = "";
      description = "The automatic webroot detection of ownCloud can fail in
        certain reverse proxy and CLI/cron situations. This option allows to
        manually override the automatic detection.";
    };

  };

  config = let
    httpd = serverInfo.serverConfig.package;

    version24 = !versionOlder httpd.version "2.4";

    allGranted = if version24 then ''
        Require all granted
    '' else ''
        Order allow,deny
        Allow from all
    '';
    nextcloudConfig = ''
            'logfile' => '${config.stateDir}/log/nextcloud.log',
            'loglevel' => 0,
            'trusted_domains' => 
            array (
            0 => 'nix.lt',
            ),
        );
        '';
    nextcloudRoot = pkgs.stdenv.mkDerivation rec {
      name = "nextcloud";
      src = pkgs.fetchgit {
        url = "https://github.com/nextcloud/server";
        rev = "f299c9b2f4cb98b6dcd79943882740f9b72dc3c0"; # v11.0.2
        sha256 = "1rnkhkdzicawhxsv67vfchjq4hrngk6whgcap13p4l1ajxxynvqj";
        fetchSubmodules = true;
      };
      installPhase = ''
        mkdir -p $out
        # copy all the nextcloud files we downloaded
        
        mv config config__

        rm *.sh
        cp -R * $out/
        cp .htaccess $out/
        
        rm -Rf $out/config
        rm -Rf $out/data
        mv $out/apps $out/apps_        
        
        ln -s ${config.stateDir}/config/ $out/config
        ln -s ${config.stateDir}/data $out/data
        ln -s ${config.stateDir}/apps $out/apps
      '';
    };
  in rec {
    webserver.variant = "apache";

    webserver.apache.extraConfig =
        ''
        ${"Alias ${config.proxyOptions.path} ${documentRoot}"}

        <Directory ${documentRoot}>
            Require all granted
            Options FollowSymLinks 
            ${builtins.readFile "${documentRoot}/.htaccess"}
        </Directory>
        ''; #"

    # FIXME: broken path, needs fixing
    #globalEnvVars = [
    #  { name = "OC_CONFIG_PATH"; value = "/var/lib/nextcloud/config/"; }
    #];

    documentRoot = nextcloudRoot;


        
    webserver.enablePHP = true;
    
    webserver.startupScript = ''
      # FEATURE HACK: there should be a command which renews this stateDir
      # HACK: as for testing we force redeployment every time!
      #       and don't use config.stateDir as it could be empty and then this would delete everything in / ....

      # FIXME: this script should not have the rights to remove mkdir -m 0750 -p "config.stateDir}/runtime"

      #rm ${config.stateDir}/.init_done

      if [ ! -f ${config.stateDir}/.init_done ]; then
        ${pkgs.postgresql}/bin/dropdb nextcloud
        rm -Rf ${config.stateDir}/config/
        rm -Rf ${config.stateDir}/data/
        rm -Rf ${config.stateDir}/apps/
        mkdir -p ${config.stateDir}/config/
        mkdir -p ${config.stateDir}/data/
        mkdir -p ${config.stateDir}/apps/
        cp -R ${nextcloudRoot}/apps_/* ${config.stateDir}/apps/

        chmod -R ug+rw ${config.stateDir}
        chmod -R o-rwx ${config.stateDir}
        chown -R ${config.user}:${config.group} ${config.stateDir}

        ${pkgs.postgresql}/bin/createuser -s -r postgres 
        ${pkgs.postgresql}/bin/createuser "${config.dbUser}" || true
        ${pkgs.postgresql}/bin/createdb "${config.dbName}" -O "${config.dbUser}" || true
        ${pkgs.sudo}/bin/sudo -u postgres ${pkgs.postgresql}/bin/psql -U postgres -d postgres -c "alter user ${config.dbUser} with password '${config.dbPassword}';" || true

        ${pkgs.sudo}/bin/sudo -u ${config.user} ${config.webserver.apache.phpPackage}/bin/php ${nextcloudRoot}/occ maintenance:install --database "pgsql" --database-name "${config.dbName}"  --database-user "${config.dbUser}" --database-pass "${config.dbPassword}" --admin-user "${config.adminUser}" --admin-pass "${config.adminPassword}"  >> ${config.stateDir}/log/install.log || true
        # maintenance:install [--database DATABASE] [--database-name DATABASE-NAME] [--database-host DATABASE-HOST] [--database-port DATABASE-PORT] [--database-user DATABASE-USER] [--database-pass [DATABASE-PASS]] [--database-table-prefix [DATABASE-TABLE-PREFIX]] [--admin-user ADMIN-USER] [--admin-pass ADMIN-PASS] [--data-dir DATA-DIR]

        # HACK: after the initial installation we have a 'vanilla' config.php and now we are going to change the config by appending values to it and rerun 'occ upgrade'
        echo "${nextcloudConfig}" > ${config.stateDir}/config/config.php_additions
        sed 's|);||' ${config.stateDir}/config/config.php > ${config.stateDir}/config/config.php_
        mv ${config.stateDir}/config/config.php_ ${config.stateDir}/config/config.php
        cat ${config.stateDir}/config/config.php_additions >> ${config.stateDir}/config/config.php
        chown ${config.user}:${config.group} ${config.stateDir}/config/config.php

        # HACK: parse and update the config.php file
        ${pkgs.sudo}/bin/sudo -u ${config.user} ${config.webserver.apache.phpPackage}/bin/php ${nextcloudRoot}/occ upgrade >> ${config.stateDir}/log/upgrade.log || true

        # HACK: after the update, revert the RW policy to only R by 'other'
        #chown root:root ${config.stateDir}/config/config.php
        #chmod ugo+r ${config.stateDir}/config/config.php

        # HACK: a backup of the original config file
        cp ${config.stateDir}/config/config.php ${config.stateDir}/config/config.php_orig

        touch ${config.stateDir}/.init_done
      fi

      ${pkgs.sudo}/bin/sudo -u ${config.user} touch ${config.stateDir}/log/nextcloud.log
      chown ${config.user}:${config.group} ${config.stateDir}/log/nextcloud.log || true
    '';

    # FIXME: implement this
    #webserver.robotsEntries = "";
  };

  meta = {
    description = "Access, share and protect your files, calendars, contacts, communication & more at home and in your enterprise";
    maintainers = with maintainers; [ qknight ];
    license = licenses.agpl3;
  };
}
