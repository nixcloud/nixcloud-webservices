{ config, lib, pkgs, wsName, mkUnique, apache, ... }:

# BUG: if you get this error message when visiting the wiki:
#    [320cfa14bce5375c4e8daf65] 2017-03-20 16:17:44: Fatal exception of type MWException
# simply remove this file:
#    rm /tmp/l10n_cache-en.cdb  

with lib;

{
  options = {
    emergencyContact = mkOption {
      default = "asdf"; # FIXME: need to add correct value
      example = "admin@example.com";
      description = ''
        Emergency contact e-mail address.  Defaults to the Apache
        admin address.
      '';
    };
    passwordSender = mkOption {
      default = "asdf"; # FIXME: need to add correct value
      example = "password@example.com";
      description = ''
        E-mail address from which password confirmations originate.
        Defaults to the Apache admin address.
      '';
    };
    siteName = mkOption {
      default = "MediaWiki";
      example = "Foobar Wiki";
      description = "Name of the wiki";
    };
    logo = mkOption {
      default = "";
      example = "/images/logo.png";
      description = "The URL of the site's logo (which should be a 135x135px image).";
    };
    urlPrefix = mkOption {
      default = "/w";
      description = ''
        The URL prefix under which the Mediawiki service appears. Currently we prepend the `proxyOptions.path` before it so the reverse proxy knows where to route the requests.
      '';
    };
    enableUploads = mkOption {
      default = false;
      description = "Whether to enable file uploads.";
    };
    uploadDir = mkOption {
      default = "You must specify `uploadDir`.";
      example = "/data/mediawiki-upload";
      description = "The directory that stores uploaded files.";
    };
    defaultSkin = mkOption {
      default = "Vector";
      example = "nostalgia";
      description = "Set this value to change the default skin used by MediaWiki.";
    };
    skins = mkOption {
      default = [];
      type = types.listOf types.path;
      description =
        ''
          List of paths whose content is copied to the ‘skins’
          subdirectory of the MediaWiki installation.
        '';
    };
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      example =
        ''
          $wgEnableEmail = false;
        '';
      description = ''
        Any additional text to be appended to MediaWiki's
        configuration file.  This is a PHP script.  For configuration
        settings, see <link xlink:href='http://www.mediawiki.org/wiki/Manual:Configuration_settings'/>.
      ''; #'
    };
  };

  config = let
    mediawikiConfig = pkgs.writeText "LocalSettings.php"
      ''
        <?php
          # Copied verbatim from the default (generated) LocalSettings.php.
          if( defined( 'MW_INSTALL_PATH' ) ) {
                  $IP = MW_INSTALL_PATH;
          } else {
                  $IP = dirname( __FILE__ );
          }

          $path = array( $IP, "$IP/includes", "$IP/languages" );
          set_include_path( implode( PATH_SEPARATOR, $path ) . PATH_SEPARATOR . get_include_path() );

          require_once( "$IP/includes/DefaultSettings.php" );

          if ( $wgCommandLineMode ) {
                  if ( isset( $_SERVER ) && array_key_exists( 'REQUEST_METHOD', $_SERVER ) ) {
                          die( "This script must be run from the command line\n" );
                  }
          }
          
          ${if config.proxyOptions.path == "/" then ''
            $wgScriptPath = "${config.urlPrefix}";
          '' else ''
            $wgScriptPath = "${config.proxyOptions.path}${config.urlPrefix}";
          ''}

          # BUG SECURITY: needs to be taken care of
          # We probably need to set $wgSecretKey and $wgCacheEpoch.

          # Paths to external programs.
          $wgDiff3 = "${pkgs.diffutils}/bin/diff3";
          $wgDiff = "${pkgs.diffutils}/bin/diff";
          $wgImageMagickConvertCommand = "${pkgs.imagemagick.out}/bin/convert";

          #$wgDebugLogFile = "/tmp/mediawiki_debug_log.txt";

          # Database configuration
          $wgDBtype = "${if config.defaultDatabaseType == "postgresql"
                         then "postgres"
                         else config.defaultDatabaseType}";
          $wgDBserver = "${config.database.mediawiki.phpHostname}";
          $wgDBuser = "${mkUnique config.database.mediawiki.user}";
          $wgDBpassword = "";
          $wgDBname = "mediawiki";

          # E-mail
          $wgEmergencyContact = "${config.emergencyContact}";
          $wgPasswordSender = "${config.passwordSender}";

          $wgSitename = "${config.siteName}";

          # FIXME: make this optiona and auto-remove /tmp/l10n_cache-en.cdb often
          wfLoadSkin( 'CologneBlue' );
          wfLoadSkin( 'Modern' );
          wfLoadSkin( 'MonoBook' );
          wfLoadSkin( 'Vector' );

          ${optionalString (config.logo != "") ''
            $wgLogo = "${config.logo}";
          ''}

          #  $wgArticlePath = '/$1';
          ${if config.proxyOptions.path == "/" then ''
          '' else ''
            $wgArticlePath = "${config.proxyOptions.path}/$1";
          ''}
          
          ${optionalString config.enableUploads ''
            $wgEnableUploads = true;
            $wgUploadDirectory = "${config.uploadDir}";
          ''}

          ${optionalString (config.defaultSkin != "") ''
            $wgDefaultSkin = "${config.defaultSkin}";
          ''}

          ${config.extraConfig}
          #$wgShowExceptionDetails = true;
        ?>
      '';

    # Unpack Mediawiki and put the config file in its root directory.
    mediawikiRoot = pkgs.stdenv.mkDerivation rec {
      name= "mediawiki-1.27.1"; # 1.29.0 – 2017-07-13

      src = pkgs.fetchurl {
        url = "http://download.wikimedia.org/mediawiki/1.27/${name}.tar.gz";
        sha256 = "0sm3ymz93qragbwhzzbwq7f127mbj29inv0afg2z6p32jb1pd9h8";
      };

      skins = config.skins;

      buildPhase =
        ''
          for skin in $skins; do
            cp -prvd $skin/* skins/
          done
        '';

      installPhase =
        ''
          mkdir -p $out
          cp -r * $out
          cp ${mediawikiConfig} $out/LocalSettings.php
          sed -i \
          -e 's|/bin/bash|${pkgs.bash}/bin/bash|g' \
          -e 's|/usr/bin/timeout|${pkgs.coreutils}/bin/timeout|g' \
            $out/includes/limit.sh \
            $out/includes/GlobalFunctions.php
        '';
    };

    mediawikiScripts = pkgs.runCommand "mediawiki-${config.uniqueName}1-scripts"
      { buildInputs = [ pkgs.makeWrapper ]; }
      ''
        mkdir -p $out/bin
        for i in changePassword.php createAndPromote.php userOptions.php edit.php nukePage.php update.php; do
          makeWrapper ${config.webserver.apache.phpPackage}/bin/php $out/bin/mediawiki-${config.uniqueName}-$(basename $i .php) \
            --add-flags ${mediawikiRoot}/maintenance/$i
        done
      '';

  in rec {
    webserver.variant = "apache";

    documentRoot = mediawikiRoot;

    extraPath = [ mediawikiScripts ];
    # BUG: need to fix /images with URL rewriting
    # BUG: need to write proper RewriteRule rule for "/" hosting -> url is borken 
    #    -> http://localhost:60000/w/index.php/Main_Page
    #      should be
    #    -> http://localhost:60000/index.php/Main_Page
    #
    #      for config.proxyOptions.path != "/" it works, why? 
    #    -> http://localhost:60000/dd/Main_Page

    webserver.apache.extraConfig = ''
      ${optionalString config.enableUploads ''
        Alias ${config.proxyOptions.path}${config.urlPrefix}/images ${config.uploadDir}

        <Directory ${config.uploadDir}>
            ${apache.allGranted}
            Options -Indexes
        </Directory>
      ''}

      ${if config.proxyOptions.path == "/" then ''
        #RewriteEngine On
        #RewriteRule ^w(/.*)?$ $1 [L]
        ${"Alias ${config.urlPrefix} ${mediawikiRoot}"}
      '' else ''
        # seems rewriteenginge wasn't required at all?!
        #RewriteEngine On
        #RewriteCond %{DOCUMENT_ROOT}%{REQUEST_URI} !-f
        #RewriteCond %{DOCUMENT_ROOT}%{REQUEST_URI} !-d
        #RewriteRule ^/?wiki${config.proxyOptions.path}${config.urlPrefix}(/.*)?$ %{DOCUMENT_ROOT}${config.proxyOptions.path}${config.urlPrefix}/index.php [L]
        Alias ${config.proxyOptions.path}${config.urlPrefix} ${mediawikiRoot}
      ''}
      Alias ${config.proxyOptions.path} ${mediawikiRoot}/index.php

      <Directory ${mediawikiRoot}>
        ${apache.allGranted}
        DirectoryIndex index.php
        AllowOverride none
      </Directory>
    '';

    webserver.enablePHP = true;

    database.mediawiki.user = config.webserver.user;
    database.mediawiki.postCreate = let
      inherit (config.database.mediawiki) type;
    in if type == "postgresql" then ''
      ( echo 'CREATE LANGUAGE plpgsql;'
        cat ${mediawikiRoot}/maintenance/postgres/tables.sql
        echo 'CREATE TEXT SEARCH CONFIGURATION public.default ( COPY = pg_catalog.english );'
        echo COMMIT
      ) | sqlsh
    '' else if type == "mysql" then ''
      sqlsh < ${mediawikiRoot}/maintenance/tables.sql
    '' else throw "Unsupported database type `${type}' for MediaWiki.";

    # BUG postgresql users must have limited rights, check the rights each start and complain if they don't match!
    webserver.startupScript = ''
      ${config.webserver.apache.phpPackage}/bin/php ${mediawikiRoot}/maintenance/update.php
    '';

    # BUG: probably broken for config.proxyOptions.path == "/"
    webserver.apache.robotsEntries = optionalString (config.proxyOptions.path != "")
      ''
        User-agent: *
        Disallow: ${config.proxyOptions.path}${config.urlPrefix}/
        Disallow: ${config.proxyOptions.path}/Special:Search
        Disallow: ${config.proxyOptions.path}/Special:Random
      '';

    tests.wanted = [ ./test.nix ];
  };

  meta = {
    description = "A wiki package written in PHP, originally for use on Wikipedia";
    maintainers = with maintainers; [ qknight ];
    license = licenses.gpl2;
    homepage = https://www.mediawiki.org/wiki/MediaWiki;
  };
}
