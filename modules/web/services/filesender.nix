{ config, options, lib, pkgs, wsName, ... }:
# https://app.assembla.com/spaces/file_sender/wiki/Installation_-_Linux_Source#client_and_server_requirements
# https://simplesamlphp.org/docs/stable/simplesamlphp-install#section_3
with lib; 

# FIXME: auth.adminpassword needs mkOption
# FIXME: check that php.ini was extended properly
# FIXME: port settings when on localhost:39999 which is hardcoded ATM
#         $config['site_url'] = $prot . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . '${config.proxyOptions.path}/'; // URL to Filesender
#         $config['site_simplesamlurl'] =  $prot . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . '${config.proxyOptions.path}' . '/simplesaml/';

{
  options = {
    dbType = mkOption {
      default = "postgres";
      example = "mysql";
      description = "Database type.";
    };
    dbName = mkOption {
      default = "filesender";
      description = "Name of the database that holds the MediaWiki data.";
    };
    dbServer = mkOption {
      default = "localhost"; # "" for using a Unix domain socket
      example = "10.0.2.2";
      description = ''
        The location of the database server.  Leave empty to use a
        database server running on the same machine through a Unix
        domain socket.
      '';
    };
    dbUser = mkOption {
      default = "filesender";
      description = "The user name for accessing the database.";
    };
    dbPassword = mkOption {
      default = "41p1wshfbj2yywlfpd1q0bdvc";
      example = "37a31qcsssss8062bd2dy";
      description = ''
        The password of the database user.  Warning: this is stored in
        cleartext in the Nix store!
      '';
    };
  };

  config = let
    httpd = config.webserver.apache.package.out;

    version24 = !versionOlder httpd.version "2.4";

    allGranted = if version24 then ''
      Require all granted
    '' else ''
      Order allow,deny
      Allow from all
    '';

  in rec {
    backend = "apache";

    filesenderConfig = pkgs.writeText "config.php" ''
      <?php

      /*
      * FileSender www.filesender.org
      * 
      * Copyright (c) 2009-2012, AARNet, Belnet, HEAnet, SURFnet, UNINETT
      * All rights reserved.
      * 
      * Redistribution and use in source and binary forms, with or without
      * modification, are permitted provided that the following conditions are met:
      * 
      * *	Redistributions of source code must retain the above copyright
      * 	notice, this list of conditions and the following disclaimer.
      * *	Redistributions in binary form must reproduce the above copyright
      * 	notice, this list of conditions and the following disclaimer in the
      * 	documentation and/or other materials provided with the distribution.
      * *	Neither the name of AARNet, Belnet, HEAnet, SURFnet and UNINETT nor the
      * 	names of its contributors may be used to endorse or promote products
      * 	derived from this software without specific prior written permission.
      * 
      * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
      * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
      * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
      * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
      * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
      * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
      * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
      * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
      * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
      * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
      */

      class config {

      private static $instance = NULL;

        public static function getInstance() {
          // Check for both equality and type
          if(self::$instance === NULL) {
            self::$instance = new self();
          }
          return self::$instance;
        }

      public function loadConfig() {

        $config = array();

        // Start of configurable settings
        // For more information about these settings please see the
        // Administrator Reference Manual in the documentation section
        // at www.filesender.org

        // General settings
        $config['admin'] = '''; // UID's (from $config['saml_uid_attribute']) that have Administrator permissions
        $config['adminEmail'] = '''; // Email address(es, separated by ,) to receive administrative messages (low disk space warning)
        $config['Default_TimeZone'] = 'Australia/Sydney';
        $config['site_defaultlanguage'] = 'en_AU'; // for available languages see the ./language directory
        $config['site_name'] = 'FileSender'; // Friendly name used for your FileSender instance

        // UI Settings
        $config['datedisplayformat'] = "d-m-Y"; // Format for displaying date/time, use PHP date() format string syntax
        $config["versionNumber"] = true; // Show version number (true/false)
        $config['site_showStats'] = false; // Show site upload/download stats (true/false)
        $config['displayUserName'] = true; // Show 'Welcome user' (true/false)
          
        // auto complete - provides auto complete in input field for emails
        $config["autocomplete"] = true;
        $config["autocompleteHistoryMax"] = ""; // "" - unlimited or integer, number of results displayed in autocomplete

        // debug settings
        $config["debug"] = false; // Debug logging on/off (true/false)
        $config["displayerrors"] = false; // Display debug errors on screen (true/false)
        $config['dnslookup'] = true; // log includes DNS lookup (true/false)
        $config["client_specific_logging"] = false; // client logging (true/false)
        $config["client_specific_logging_uids"] = ""; // "" is log all clients, or log for specific userid's or voucheruid's seperated by comma 'xxxx,zzzzz'

        // saml settings
        $config['saml_email_attribute'] = 'mail'; // Attribute used for email address
        $config['saml_name_attribute'] = 'cn'; // Attribute used to get the user's name
        $config['saml_uid_attribute'] = 'eduPersonTargetedID'; // Attribute to uniquely identify the user

        // AuP settings
        $config["AuP_default"] = false; //AuP value is already ticked
        $config["AuP"] = true; // AuP is displayed

        // Server settings
        $config['default_daysvalid'] = 20; // Maximum number of days before file/voucher is expired
        $config['ban_extension'] = 'exe,bat'; // Possibly dangerous file extensions that are disallowed
        $config["max_email_recipients"] = 100; // maximum email addresses allowed to send at once for voucher or file sending, a value of 0 allows unlimited emails.
        $config['download_confirmation_to_downloader'] = true ; // send copy of download confirmation to downloader (true/false, default true)

        $config['max_flash_upload_size'] = '2147483648'; // 2GB
        $config['max_html5_upload_size'] = '107374182400'; // 100  GB
        $config["upload_chunk_size"]  = '2000000';//

        // update max_flash_upload_size if php.ini post_max_size and upload_max_filesize is set lower
        $config['max_flash_upload_size'] = min(let_to_num(ini_get('post_max_size'))-2048, let_to_num(ini_get('upload_max_filesize')),$config['max_flash_upload_size']);

        $config["server_drivespace_warning"] = 20; // as a percentage 20 = 20% space left on the storage drive

        // Terasender (fast upload) settings
        // - terasender (really fast uploads) uses html5 web workers to speed up file upload
        // - effectively providing multi-threaded faster uploads
        $config['terasender'] = false; // true/false
        $config['terasenderadvanced'] = false; // true/false - terasender advanced - show advanced settings
        $config['terasender_chunksize'] = 5;		// default (5) terasender chunk size in MB
        $config['terasender_workerCount'] = 6;		// default (6) worker count
        $config['terasender_jobsPerWorker'] = 1;	// default (1) jobs per worker

        // Advanced server settings, do not change unless you have a very good reason.
        $config['db_dateformat'] = "Y-m-d H:i:sP"; // Date/Time format for PostgreSQL, use PHP date format specifier syntax
        $config["crlf"] = "\n"; // for email CRLF can be changed to \r\n if required
        $config['voucherRegEx'] = "'[a-zA-Z0-9]{8}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{12}'";
        $config['voucherUIDLength'] = 36;
        $config['emailRegEx'] = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

        // site URL settings
        if ( isset($_SERVER['SERVER_NAME']) ) {
        $prot =  isset($_SERVER['HTTPS']) ? 'https://' : 'http://';
        $config['site_url'] = $prot . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . '${config.proxyOptions.path}/'; // URL to Filesender
        $config['site_simplesamlurl'] =  $prot . $_SERVER['SERVER_NAME'] . ":" . $_SERVER['SERVER_PORT'] . '${config.proxyOptions.path}' . '/simplesaml/';
        $config['site_authenticationSource'] ="default-sp";
        $config['site_logouturl'] = $config['site_url'] . '?s=logout';
        }
        $config['forceSSL'] = false; // Always use SSL (true/false)

        // Support links
        $config['aboutURL'] = "";
        $config['helpURL'] = "";

        // (absolute) file locations
        $config['site_filestore'] = '../files/';
        $config['site_temp_filestore'] = '../tmp/';
        $config['site_simplesamllocation'] = '../simplesaml/';
        $config['log_location'] = '../log/';

        $config["db_type"] = "pgsql"; // pgsql or mysql
        $config['db_host'] = '${config.dbServer}';
        $config['db_database'] = '${config.dbName}';
        $config['db_port'] = '5432';
        // database username and password
        $config['db_username'] = '${config.dbUser}';
        $config['db_password'] = '${config.dbPassword}';

        //Optional DSN format overides db_ settings
        //$config['dsn'] = "pgsql:host=localhost;dbname=filesender";
        //$config['dsn'] = 'pgsql:host=localhost;dbname=filesender';
        //$config['dsn'] = 'sqlite:/usr/share/filesender/db/filesender.sqlite';
        //$config['dsn_driver_options'] = array();
        // dsn requires username and password in $config['db_username'] and $config['db_password']

        // cron settings
        $config['cron_exclude prefix'] = '_'; // exclude deletion of files with the prefix character listed (can use multiple characters eg '._' will ignore .xxxx and _xxxx
        $config['cron_shred'] = false; // instead of simply unlinking, overwrite expired files so they are hard to recover
        $config['cron_shred_command'] = '/usr/bin/shred -f -u -n 1 -z'; // overwrite once (-n 1) with random data, once with zeros (-z), then remove (-u)
        $config["cron_cleanuptempdays"] = 7; // number of days to keep temporary files in the temp_filestore

        // email templates section
        $config['default_emailsubject'] = "{siteName}: {filename}";
        $config['filedownloadedemailbody'] = '{CRLF}--simple_mime_boundary{CRLF}Content-type:text/plain; charset={charset}{CRLF}{CRLF}
      Dear Sir, Madam,

      The file below has been downloaded from {siteName} by {filefrom}.

      Filename: {fileoriginalname}
      Filesize: {filesize}
      Download link: {serverURL}?vid={filevoucheruid}

      The file is available until {fileexpirydate} after which it will be automatically deleted.

      Best regards,

      {siteName}{CRLF}{CRLF}--simple_mime_boundary{CRLF}Content-type:text/html; charset={charset}{CRLF}{CRLF}
      <HTML>
      <HEAD>
      <meta http-equiv="Content-Type" content="text/html;charset={charset}">
      </HEAD>
      <BODY>
      <P>Dear Sir, Madam,</P>
      <P>The file below has been downloaded from {siteName} by {filefrom}.</P>
      <TABLE WIDTH=100% BORDER=1 BORDERCOLOR="#000000" CELLPADDING=4 CELLSPACING=0>
        <COL WIDTH=600>
        <COL WIDTH=80>
        <COL WIDTH=800>
        <COL WIDTH=70>
        <TR>
          <TD WIDTH=600 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Filename</B></P>
          </TD>
          <TD WIDTH=80 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Filesize</B></P>
          </TD>
          <TD WIDTH=600 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Download link</B></P>
          </TD>
          <TD WIDTH=70 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Valid until</B></P>
          </TD>
        </TR>
        <TR>
          <TD WIDTH=600 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER>{htmlfileoriginalname}</P>
          </TD>
          <TD WIDTH=80 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER>{filesize}</P>
          </TD>
          <TD WIDTH=800 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER><A HREF="{serverURL}?vid={filevoucheruid}">{serverURL}?vid={filevoucheruid}</A></P>
          </TD>
          <TD WIDTH=70 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER>{fileexpirydate}</P>
          </TD>
        </TR>
      </TABLE>
      <P>Best regards,</P>
      <P>{siteName}</P>
      </BODY>
      </HTML>{CRLF}{CRLF}--simple_mime_boundary--';
        $config['fileuploadedemailbody'] = '{CRLF}--simple_mime_boundary{CRLF}Content-type:text/plain; charset={charset}{CRLF}{CRLF}
      Dear Sir, Madam,

      The file below has been uploaded to {siteName} by {filefrom} and you have been granted permission to download this file.

      Filename: {fileoriginalname}
      Filesize: {filesize}
      Download link: {serverURL}?vid={filevoucheruid}

      The file is available until {fileexpirydate} after which it will be automatically deleted.

      {filemessage_start}Personal message from {filefrom}: {filemessage}{filemessage_end}

      Best regards,

      {siteName}{CRLF}{CRLF}--simple_mime_boundary{CRLF}Content-type:text/html; charset={charset}{CRLF}{CRLF}
      <HTML>
      <HEAD>
      <meta http-equiv="Content-Type" content="text/html;charset={charset}">
      </HEAD>
      <BODY>
      <P>Dear Sir, Madam,</P>
      <P>The file below has been uploaded to {siteName} by {filefrom} and you have been granted permission to download this file.</P>
      <TABLE WIDTH=100% BORDER=1 BORDERCOLOR="#000000" CELLPADDING=4 CELLSPACING=0>
        <COL WIDTH=600>
        <COL WIDTH=80>
        <COL WIDTH=800>
        <COL WIDTH=70>
        <TR>
          <TD WIDTH=600 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Filename</B></P>
          </TD>
          <TD WIDTH=80 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Filesize</B></P>
          </TD>
          <TD WIDTH=600 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Download link</B></P>
          </TD>
          <TD WIDTH=70 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Valid until</B></P>
          </TD>
        </TR>
        <TR>
          <TD WIDTH=600 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER>{htmlfileoriginalname}</P>
          </TD>
          <TD WIDTH=80 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER>{filesize}</P>
          </TD>
          <TD WIDTH=800 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER><A HREF="{serverURL}?vid={filevoucheruid}">{serverURL}?vid={filevoucheruid}</A></P>
          </TD>
          <TD WIDTH=70 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER>{fileexpirydate}</P>
          </TD>
        </TR>
      </TABLE>
      <P></P>
      {filemessage_start}<TABLE WIDTH=100% BORDER=1 BORDERCOLOR="#000000" CELLPADDING=4 CELLSPACING=0>
        <COL WIDTH=100%>
        <TR>
          <TD WIDTH=100% BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Personal message from {filefrom}:</B></P>
          </TD>
        </TR>
        <TR>
          <TD WIDTH=100% BGCOLOR="#e6e6e6">
            <P><I>{htmlfilemessage}</I></P>
          </TD>
        </TR>
      </TABLE>{filemessage_end}
      <P>Best regards,</P>
      <P>{siteName}</P>
      </BODY>
      </HTML>{CRLF}{CRLF}--simple_mime_boundary--';

        $config['voucherissuedemailsubject'] = 'Voucher';
        $config['voucherissuedemailbody'] = '{CRLF}--simple_mime_boundary{CRLF}Content-type:text/plain; charset={charset}{CRLF}{CRLF}
      Dear Sir, Madam,

      Please, find below a voucher which grants access to {siteName}.
      With this voucher you can upload once one file and make it available for download to a group of people.

      Issuer: {filefrom}
      Voucher link: {serverURL}?vid={filevoucheruid}

      The voucher is available until {fileexpirydate} after which it will be automatically deleted.

      {filemessage_start}Personal message from {filefrom}: {filemessage}{filemessage_end}

      Best regards,

      {siteName}{CRLF}{CRLF}--simple_mime_boundary{CRLF}Content-type:text/html; charset={charset}{CRLF}{CRLF}
      <HTML>
      <HEAD>
      <meta http-equiv="Content-Type" content="text/html;charset={charset}">
      </HEAD>
      <BODY>
      <P>Dear Sir, Madam,</P>
      <P>Please, find below a voucher which grants access to {siteName}.</P>
      <P>With this voucher you can upload once one file and make it available for download to a group of people.</P>
      <TABLE WIDTH=100% BORDER=1 BORDERCOLOR="#000000" CELLPADDING=4 CELLSPACING=0>
        <COL WIDTH=75>
        <COL WIDTH=800>
        <COL WIDTH=70>
        <TR>
          <TD WIDTH=75 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Issuer</B></P>
          </TD>
          <TD WIDTH=800 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Voucher link</B></P>
          </TD>
          <TD WIDTH=70 BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Valid until</B></P>
          </TD>
        </TR>
        <TR>
          <TD WIDTH=75 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER>{filefrom}</P>
          </TD>
          <TD WIDTH=800 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER><A HREF="{serverURL}?vid={filevoucheruid}">{serverURL}?vid={filevoucheruid}</A></P>
          </TD>
          <TD WIDTH=70 BGCOLOR="#e6e6e6">
            <P ALIGN=CENTER>{fileexpirydate}</P>
          </TD>
        </TR>
      </TABLE>
      <P></P>
      {filemessage_start}<TABLE WIDTH=100% BORDER=1 BORDERCOLOR="#000000" CELLPADDING=4 CELLSPACING=0>
        <COL WIDTH=100%>
        <TR>
          <TD WIDTH=100% BGCOLOR="#b3b3b3">
            <P ALIGN=CENTER><B>Personal message from {filefrom}:</B></P>
          </TD>
        </TR>
        <TR>
          <TD WIDTH=100% BGCOLOR="#e6e6e6">
            <P><I>{htmlfilemessage}</I></P>
          </TD>
        </TR>
      </TABLE>{filemessage_end}
      <p></p>
      <P>Best regards,</P>
      <P>{siteName}</P>
      </BODY>
      </HTML>{CRLF}{CRLF}--simple_mime_boundary--';

        $config['defaultvouchercancelled'] = "{CRLF}--simple_mime_boundary{CRLF}Content-type:text/plain; charset={charset}{CRLF}{CRLF}
      Dear Sir, Madam,

      A voucher from {filefrom} has been cancelled.

      Best regards,

      {siteName}{CRLF}{CRLF}--simple_mime_boundary{CRLF}Content-type:text/html; charset={charset}{CRLF}{CRLF}
      <HTML>
      <HEAD>
      <meta http-equiv=\"Content-Type\" content=\"text/html;charset={charset}\">
      </HEAD>
      <BODY>
      Dear Sir, Madam,<BR><BR>A voucher from {filefrom} has been cancelled.<BR><BR>
        <P>Best regards,</P>
      <P>{siteName}</P>
      </BODY>
      </HTML>{CRLF}{CRLF}--simple_mime_boundary--";

        $config['defaultfilecancelled'] = "{CRLF}--simple_mime_boundary{CRLF}Content-type:text/plain; charset={charset}{CRLF}{CRLF}
      Dear Sir, Madam,

      The file '{fileoriginalname}' from {filefrom} has been deleted and is no longer available to download.

      Best regards,

      {siteName}{CRLF}{CRLF}--simple_mime_boundary{CRLF}Content-type:text/html; charset={charset}{CRLF}{CRLF}
      <HTML>
      <BODY>
      Dear Sir, Madam,<BR><BR>The file '{htmlfileoriginalname}' from {filefrom} has been deleted and is no longer available to download.<BR><BR>
        <P>Best regards,</P>
      <P>{siteName}</P>
      </BODY>
      </HTML>{CRLF}{CRLF}--simple_mime_boundary--";
        // End of email templates section

        // End of configurable settings

        return $config;
        }
      }

      // Helper function used when calculating maximum upload size from the various maxsize configuration items
      function let_to_num($v){ //This function transforms the php.ini notation for numbers (like '2M') to an integer (2*1024*1024 in this case)
          $ret = trim($v);
          $last = strtoupper($ret[strlen($ret)-1]);
          switch($last) {
          case 'P':
              $ret *= 1024;
          case 'T':
              $ret *= 1024;
          case 'G':
              $ret *= 1024;
          case 'M':
              $ret *= 1024;
          case 'K':
              $ret *= 1024;
              break;
          }
            return $ret;
      }
      ?>
    ''; #'

    # FIXME: make this an mkOption 'trusted.url.domains' => array('localhost','localhost:39999', '127.0.0.1'),
    #        without this i get an unhandled exception 
    
    simplesamlConfig = pkgs.writeText "config.php" ''
      <?php
      /* 
      * The configuration of SimpleSAMLphp
      * 
      */

      $config = array(

      /**
      * Setup the following parameters to match the directory of your installation.
      * See the user manual for more details.
      *
      * Valid format for baseurlpath is:
      * [(http|https)://(hostname|fqdn)[:port]]/[path/to/simplesaml/]
      * (note that it must end with a '/')
      *
      * The full url format is useful if your SimpleSAMLphp setup is hosted behind
      * a reverse proxy. In that case you can specify the external url here.
      *
      * Please note that SimpleSAMLphp will then redirect all queries to the
      * external url, no matter where you come from (direct access or via the
      * reverse proxy).
      */
      'baseurlpath' => '${config.proxyOptions.path}/simplesaml/',
      'certdir' => 'cert/',
      'loggingdir' => 'log/',
      'datadir' => 'data/',

      /*
      * A directory where SimpleSAMLphp can save temporary files.
      *
      * SimpleSAMLphp will attempt to create this directory if it doesn't exist.
      */
      'tempdir' => '/tmp/simplesaml',


      /*
      * If you enable this option, SimpleSAMLphp will log all sent and received messages
      * to the log file.
      *
      * This option also enables logging of the messages that are encrypted and decrypted.
      *
      * Note: The messages are logged with the DEBUG log level, so you also need to set
      * the 'logging.level' option to LOG_DEBUG.
      */
      'debug' => true,

      /*
      * When showerrors is enabled, all error messages and stack traces will be output
      * to the browser.
      *
      * When errorreporting is enabled, a form will be presented for the user to report
      * the error to technicalcontact_email.
      */
      'showerrors' => true,
      'errorreporting' => true,

      /**
      * Custom error show function called from SimpleSAML_Error_Error::show.
      * See docs/simplesamlphp-errorhandling.txt for function code example.
      *
      * Example:
      *   'errors.show_function' => array('sspmod_example_Error_Show', 'show'),
      */

      /**
      * This option allows you to enable validation of XML data against its
      * schemas. A warning will be written to the log if validation fails.
      */
      'debug.validatexml' => false,

      /**
      * This password must be kept secret, and modified from the default value 123.
      * This password will give access to the installation page of SimpleSAMLphp with
      * metadata listing and diagnostics pages.
      * You can also put a hash here; run "bin/pwgen.php" to generate one.
      */
      'auth.adminpassword' => '1234',  
      'admin.protectindexpage' => false,
      'admin.protectmetadata' => false,

      /**
      * This is a secret salt used by SimpleSAMLphp when it needs to generate a secure hash
      * of a value. It must be changed from its default value to a secret value. The value of
      * 'secretsalt' can be any valid string of any length.
      *
      * A possible way to generate a random salt is by running the following command from a unix shell:
      * tr -c -d '0123456789abcdefghijklmnopqrstuvwxyz' </dev/urandom | dd bs=32 count=1 2>/dev/null;echo
      */
      'secretsalt' => 'defaultsecretsalt',

      /*
      * Some information about the technical persons running this installation.
      * The email address will be used as the recipient address for error reports, and
      * also as the technical contact in generated metadata.
      */
      'technicalcontact_name' => 'Administrator',
      'technicalcontact_email' => 'na@example.org',

      /*
      * The timezone of the server. This option should be set to the timezone you want
      * SimpleSAMLphp to report the time in. The default is to guess the timezone based
      * on your system timezone.
      *
      * See this page for a list of valid timezones: http://php.net/manual/en/timezones.php
      */
      'timezone' => null,

      /*
      * Logging.
      *
      * define the minimum log level to log
      *		SimpleSAML_Logger::ERR		No statistics, only errors
      *		SimpleSAML_Logger::WARNING	No statistics, only warnings/errors
      *		SimpleSAML_Logger::NOTICE	Statistics and errors
      *		SimpleSAML_Logger::INFO		Verbose logs
      *		SimpleSAML_Logger::DEBUG	Full debug logs - not recommended for production
      *
      * Choose logging handler.
      *
      * Options: [syslog,file,errorlog]
      *
      */
      'logging.level' => SimpleSAML_Logger::NOTICE,
      'logging.handler' => 'syslog',

      /*
      * Specify the format of the logs. Its use varies depending on the log handler used (for instance, you cannot
      * control here how dates are displayed when using the syslog or errorlog handlers), but in general the options
      * are:
      *
      * - %date{<format>}: the date and time, with its format specified inside the brackets. See the PHP documentation
      *   of the strftime() function for more information on the format. If the brackets are omitted, the standard
      *   format is applied. This can be useful if you just want to control the placement of the date, but don't care
      *   about the format.
      *
      * - %process: the name of the SimpleSAMLphp process. Remember you can configure this in the 'logging.processname'
      *   option below.
      *
      * - %level: the log level (name or number depending on the handler used).
      *
      * - %stat: if the log entry is intended for statistical purposes, it will print the string 'STAT ' (bear in mind
      *   the trailing space).
      *
      * - %trackid: the track ID, an identifier that allows you to track a single session.
      *
      * - %srcip: the IP address of the client. If you are behind a proxy, make sure to modify the
      *   $_SERVER['REMOTE_ADDR'] variable on your code accordingly to the X-Forwarded-For header.
      *
      * - %msg: the message to be logged.
      *
      */
      //'logging.format' => '%date{%b %d %H:%M:%S} %process %level %stat[%trackid] %msg',

      /*
      * Choose which facility should be used when logging with syslog.
      *
      * These can be used for filtering the syslog output from SimpleSAMLphp into its
      * own file by configuring the syslog daemon.
      *
      * See the documentation for openlog (http://php.net/manual/en/function.openlog.php) for available
      * facilities. Note that only LOG_USER is valid on windows.
      *
      * The default is to use LOG_LOCAL5 if available, and fall back to LOG_USER if not.
      */
      'logging.facility' => defined('LOG_LOCAL5') ? constant('LOG_LOCAL5') : LOG_USER,

      /*
      * The process name that should be used when logging to syslog.
      * The value is also written out by the other logging handlers.
      */
      'logging.processname' => 'simplesamlphp',

      /* Logging: file - Logfilename in the loggingdir from above.
      */
      'logging.logfile' => 'simplesamlphp.log',

      /* (New) statistics output configuration.
      *
      * This is an array of outputs. Each output has at least a 'class' option, which
      * selects the output.
      */
      'statistics.out' => array(// Log statistics to the normal log.
          /*
          array(
              'class' => 'core:Log',
              'level' => 'notice',
          ),
          */
          // Log statistics to files in a directory. One file per day.
          /*
          array(
              'class' => 'core:File',
              'directory' => '/var/log/stats',
          ),
          */
      ),



      /*
      * Database
      *
      * This database configuration is optional. If you are not using
      * core functionality or modules that require a database, you can
      * skip this configuration.
      */

      /*
      * Database connection string.
      * Ensure that you have the required PDO database driver installed
      * for your connection string.
      */
      'database.dsn' => 'mysql:host=localhost;dbname=saml',

      /*
      * SQL database credentials
      */
      'database.username' => 'simplesamlphp',
      'database.password' => 'secret',

      /*
      * (Optional) Table prefix
      */
      'database.prefix' => ''',

      /*
      * True or false if you would like a persistent database connection
      */
      'database.persistent' => false,

      /*
      * Database slave configuration is optional as well. If you are only
      * running a single database server, leave this blank. If you have
      * a master/slave configuration, you can define as many slave servers
      * as you want here. Slaves will be picked at random to be queried from.
      *
      * Configuration options in the slave array are exactly the same as the
      * options for the master (shown above) with the exception of the table
      * prefix.
      */
      'database.slaves' => array(
          /*
          array(
              'dsn' => 'mysql:host=myslave;dbname=saml',
              'username' => 'simplesamlphp',
              'password' => 'secret',
              'persistent' => false,
          ),
          */
      ),



      /*
      * Enable
      *
      * Which functionality in SimpleSAMLphp do you want to enable. Normally you would enable only
      * one of the functionalities below, but in some cases you could run multiple functionalities.
      * In example when you are setting up a federation bridge.
      */
      'enable.saml20-idp' => false,
      'enable.shib13-idp' => false,
      'enable.adfs-idp' => false,
      'enable.wsfed-sp' => false,
      'enable.authmemcookie' => false,


      /*
      * Module enable configuration
      *
      * Configuration to override module enabling/disabling.
      *
      * Example:
      *
      * 'module.enable' => array(
      * 	// Setting to TRUE enables.
      * 	'exampleauth' => TRUE,
      * 	// Setting to FALSE disables.
      * 	'saml' => FALSE,
      * 	// Unset or NULL uses default.
      * 	'core' => NULL,
      * ),
      *
      */


      /*
      * This value is the duration of the session in seconds. Make sure that the time duration of
      * cookies both at the SP and the IdP exceeds this duration.
      */
      'session.duration' => 8 * (60 * 60), // 8 hours.

      /*
      * Sets the duration, in seconds, data should be stored in the datastore. As the datastore is used for
      * login and logout requests, thid option will control the maximum time these operations can take.
      * The default is 4 hours (4*60*60) seconds, which should be more than enough for these operations.
      */
      'session.datastore.timeout' => (4 * 60 * 60), // 4 hours

      /*
      * Sets the duration, in seconds, auth state should be stored.
      */
      'session.state.timeout' => (60 * 60), // 1 hour

      /*
      * Option to override the default settings for the session cookie name
      */
      'session.cookie.name' => 'SimpleSAMLSessionID',

      /*
      * Expiration time for the session cookie, in seconds.
      *
      * Defaults to 0, which means that the cookie expires when the browser is closed.
      *
      * Example:
      *  'session.cookie.lifetime' => 30*60,
      */
      'session.cookie.lifetime' => 0,

      /*
      * Limit the path of the cookies.
      *
      * Can be used to limit the path of the cookies to a specific subdirectory.
      *
      * Example:
      *  'session.cookie.path' => '/simplesaml/',
      */
      'session.cookie.path' => '/',

      /*
      * Cookie domain.
      *
      * Can be used to make the session cookie available to several domains.
      *
      * Example:
      *  'session.cookie.domain' => '.example.org',
      */
      'session.cookie.domain' => null,

      /*
      * Set the secure flag in the cookie.
      *
      * Set this to TRUE if the user only accesses your service
      * through https. If the user can access the service through
      * both http and https, this must be set to FALSE.
      */
      'session.cookie.secure' => false,

      /*
      * Enable secure POST from HTTPS to HTTP.
      *
      * If you have some SP's on HTTP and IdP is normally on HTTPS, this option
      * enables secure POSTing to HTTP endpoint without warning from browser.
      *
      * For this to work, module.php/core/postredirect.php must be accessible
      * also via HTTP on IdP, e.g. if your IdP is on
      * https://idp.example.org/ssp/, then
      * http://idp.example.org/ssp/module.php/core/postredirect.php must be accessible.
      */
      'enable.http_post' => false,

      /*
      * Options to override the default settings for php sessions.
      */
      'session.phpsession.cookiename' => null,
      'session.phpsession.savepath' => null,
      'session.phpsession.httponly' => true,

      /*
      * Option to override the default settings for the auth token cookie
      */
      'session.authtoken.cookiename' => 'SimpleSAMLAuthToken',

      /*
      * Options for remember me feature for IdP sessions. Remember me feature
      * has to be also implemented in authentication source used.
      *
      * Option 'session.cookie.lifetime' should be set to zero (0), i.e. cookie
      * expires on browser session if remember me is not checked.
      *
      * Session duration ('session.duration' option) should be set according to
      * 'session.rememberme.lifetime' option.
      *
      * It's advised to use remember me feature with session checking function
      * defined with 'session.check_function' option.
      */
      'session.rememberme.enable' => false,
      'session.rememberme.checked' => false,
      'session.rememberme.lifetime' => (14 * 86400),

      /**
      * Custom function for session checking called on session init and loading.
      * See docs/simplesamlphp-advancedfeatures.txt for function code example.
      *
      * Example:
      *   'session.check_function' => array('sspmod_example_Util', 'checkSession'),
      */

      /*
      * Languages available, RTL languages, and what language is default
      */
      'language.available' => array(
          'en', 'no', 'nn', 'se', 'da', 'de', 'sv', 'fi', 'es', 'fr', 'it', 'nl', 'lb', 'cs',
          'sl', 'lt', 'hr', 'hu', 'pl', 'pt', 'pt-br', 'tr', 'ja', 'zh', 'zh-tw', 'ru', 'et',
          'he', 'id', 'sr', 'lv', 'ro', 'eu'
      ),
      'language.rtl' => array('ar', 'dv', 'fa', 'ur', 'he'),
      'language.default' => 'en',

      /*
      * Options to override the default settings for the language parameter
      */
      'language.parameter.name' => 'language',
      'language.parameter.setcookie' => true,

      /*
      * Options to override the default settings for the language cookie
      */
      'language.cookie.name' => 'language',
      'language.cookie.domain' => null,
      'language.cookie.path' => '/',
      'language.cookie.lifetime' => (60 * 60 * 24 * 900),

      /**
      * Custom getLanguage function called from SimpleSAML_XHTML_Template::getLanguage().
      * Function should return language code of one of the available languages or NULL.
      * See SimpleSAML_XHTML_Template::getLanguage() source code for more info.
      *
      * This option can be used to implement a custom function for determining
      * the default language for the user.
      *
      * Example:
      *   'language.get_language_function' => array('sspmod_example_Template', 'getLanguage'),
      */

      /*
      * Extra dictionary for attribute names.
      * This can be used to define local attributes.
      *
      * The format of the parameter is a string with <module>:<dictionary>.
      *
      * Specifying this option will cause us to look for modules/<module>/dictionaries/<dictionary>.definition.json
      * The dictionary should look something like:
      *
      * {
      *     "firstattribute": {
      *         "en": "English name",
      *         "no": "Norwegian name"
      *     },
      *     "secondattribute": {
      *         "en": "English name",
      *         "no": "Norwegian name"
      *     }
      * }
      *
      * Note that all attribute names in the dictionary must in lowercase.
      *
      * Example: 'attributes.extradictionary' => 'ourmodule:ourattributes',
      */
      'attributes.extradictionary' => null,

      /*
      * Which theme directory should be used?
      */
      'theme.use' => 'default',


      /*
      * Default IdP for WS-Fed.
      */
      'default-wsfed-idp' => 'urn:federation:pingfederate:localhost',

      /*
      * Whether the discovery service should allow the user to save his choice of IdP.
      */
      'idpdisco.enableremember' => true,
      'idpdisco.rememberchecked' => true,

      // Disco service only accepts entities it knows.
      'idpdisco.validate' => true,

      'idpdisco.extDiscoveryStorage' => null,

      /*
      * IdP Discovery service look configuration.
      * Wether to display a list of idp or to display a dropdown box. For many IdP' a dropdown box
      * gives the best use experience.
      *
      * When using dropdown box a cookie is used to highlight the previously chosen IdP in the dropdown.
      * This makes it easier for the user to choose the IdP
      *
      * Options: [links,dropdown]
      *
      */
      'idpdisco.layout' => 'dropdown',

      /*
      * Whether SimpleSAMLphp should sign the response or the assertion in SAML 1.1 authentication
      * responses.
      *
      * The default is to sign the assertion element, but that can be overridden by setting this
      * option to TRUE. It can also be overridden on a pr. SP basis by adding an option with the
      * same name to the metadata of the SP.
      */
      'shib13.signresponse' => true,


      /*
      * Authentication processing filters that will be executed for all IdPs
      * Both Shibboleth and SAML 2.0
      */
      'authproc.idp' => array(
          /* Enable the authproc filter below to add URN Prefixces to all attributes
          10 => array(
              'class' => 'core:AttributeMap', 'addurnprefix'
          ), */
          /* Enable the authproc filter below to automatically generated eduPersonTargetedID.
          20 => 'core:TargetedID',
          */

          // Adopts language from attribute to use in UI
          30 => 'core:LanguageAdaptor',

          /* Add a realm attribute from edupersonprincipalname
          40 => 'core:AttributeRealm',
          */
          45 => array(
              'class'         => 'core:StatisticsWithAttribute',
              'attributename' => 'realm',
              'type'          => 'saml20-idp-SSO',
          ),

          /* When called without parameters, it will fallback to filter attributes ‹the old way›
          * by checking the 'attributes' parameter in metadata on IdP hosted and SP remote.
          */
          50 => 'core:AttributeLimit',

          /*
          * Search attribute "distinguishedName" for pattern and replaces if found

          60 => array(
              'class' => 'core:AttributeAlter',
              'pattern' => '/OU=studerende/',
              'replacement' => 'Student',
              'subject' => 'distinguishedName',
              '%replace',
          ),
          */

          /*
          * Consent module is enabled (with no permanent storage, using cookies).

          90 => array(
              'class' => 'consent:Consent',
              'store' => 'consent:Cookie',
              'focus' => 'yes',
              'checked' => TRUE
          ),
          */
          // If language is set in Consent module it will be added as an attribute.
          99 => 'core:LanguageAdaptor',
      ),
      /*
      * Authentication processing filters that will be executed for all SPs
      * Both Shibboleth and SAML 2.0
      */
      'authproc.sp' => array(
          /*
          10 => array(
              'class' => 'core:AttributeMap', 'removeurnprefix'
          ),
          */

          /*
          * Generate the 'group' attribute populated from other variables, including eduPersonAffiliation.
          60 => array(
              'class' => 'core:GenerateGroups', 'eduPersonAffiliation'
          ),
          */
          /*
          * All users will be members of 'users' and 'members'
          61 => array(
              'class' => 'core:AttributeAdd', 'groups' => array('users', 'members')
          ),
          */

          // Adopts language from attribute to use in UI
          90 => 'core:LanguageAdaptor',

      ),


      /*
      * This option configures the metadata sources. The metadata sources is given as an array with
      * different metadata sources. When searching for metadata, simpleSAMPphp will search through
      * the array from start to end.
      *
      * Each element in the array is an associative array which configures the metadata source.
      * The type of the metadata source is given by the 'type' element. For each type we have
      * different configuration options.
      *
      * Flat file metadata handler:
      * - 'type': This is always 'flatfile'.
      * - 'directory': The directory we will load the metadata files from. The default value for
      *                this option is the value of the 'metadatadir' configuration option, or
      *                'metadata/' if that option is unset.
      *
      * XML metadata handler:
      * This metadata handler parses an XML file with either an EntityDescriptor element or an
      * EntitiesDescriptor element. The XML file may be stored locally, or (for debugging) on a remote
      * web server.
      * The XML hetadata handler defines the following options:
      * - 'type': This is always 'xml'.
      * - 'file': Path to the XML file with the metadata.
      * - 'url': The URL to fetch metadata from. THIS IS ONLY FOR DEBUGGING - THERE IS NO CACHING OF THE RESPONSE.
      *
      * MDX metadata handler:
      * This metadata handler looks up for the metadata of an entity at the given MDX server.
      * The MDX metadata handler defines the following options:
      * - 'type': This is always 'mdx'.
      * - 'server': URL of the MDX server (url:port). Mandatory.
      * - 'validateFingerprint': The fingerprint of the certificate used to sign the metadata.
      *                          You don't need this option if you don't want to validate the signature on the metadata. Optional.
      * - 'cachedir': Directory where metadata can be cached. Optional.
      * - 'cachelength': Maximum time metadata cah be cached, in seconds. Default to 24
      *                  hours (86400 seconds). Optional.
      *
      * PDO metadata handler:
      * This metadata handler looks up metadata of an entity stored in a database.
      *
      * Note: If you are using the PDO metadata handler, you must configure the database
      * options in this configuration file.
      *
      * The PDO metadata handler defines the following options:
      * - 'type': This is always 'pdo'.
      *
      *
      * Examples:
      *
      * This example defines two flatfile sources. One is the default metadata directory, the other
      * is a metadata directory with autogenerated metadata files.
      *
      * 'metadata.sources' => array(
      *     array('type' => 'flatfile'),
      *     array('type' => 'flatfile', 'directory' => 'metadata-generated'),
      *     ),
      *
      * This example defines a flatfile source and an XML source.
      * 'metadata.sources' => array(
      *     array('type' => 'flatfile'),
      *     array('type' => 'xml', 'file' => 'idp.example.org-idpMeta.xml'),
      *     ),
      *
      * This example defines an mdx source.
      * 'metadata.sources' => array(
      *     array('type' => 'mdx', server => 'http://mdx.server.com:8080', 'cachedir' => '/var/simplesamlphp/mdx-cache', 'cachelength' => 86400)
      *     ),
      *
      * This example defines an pdo source.
      * 'metadata.sources' => array(
      *     array('type' => 'pdo')
      *     ),
      *
      * Default:
      * 'metadata.sources' => array(
      *     array('type' => 'flatfile')
      *     ),
      */
      'metadata.sources' => array(
          array('type' => 'flatfile'),
      ),


      /*
      * Configure the datastore for SimpleSAMLphp.
      *
      * - 'phpsession': Limited datastore, which uses the PHP session.
      * - 'memcache': Key-value datastore, based on memcache.
      * - 'sql': SQL datastore, using PDO.
      *
      * The default datastore is 'phpsession'.
      *
      * (This option replaces the old 'session.handler'-option.)
      */
      'store.type'                    => 'phpsession',


      /*
      * The DSN the sql datastore should connect to.
      *
      * See http://www.php.net/manual/en/pdo.drivers.php for the various
      * syntaxes.
      */
      'store.sql.dsn'                 => 'sqlite:/path/to/sqlitedatabase.sq3',

      /*
      * The username and password to use when connecting to the database.
      */
      'store.sql.username' => null,
      'store.sql.password' => null,

      /*
      * The prefix we should use on our tables.
      */
      'store.sql.prefix' => 'SimpleSAMLphp',


      /*
      * Configuration for the 'memcache' session store. This allows you to store
      * multiple redundant copies of sessions on different memcache servers.
      *
      * 'memcache_store.servers' is an array of server groups. Every data
      * item will be mirrored in every server group.
      *
      * Each server group is an array of servers. The data items will be
      * load-balanced between all servers in each server group.
      *
      * Each server is an array of parameters for the server. The following
      * options are available:
      *  - 'hostname': This is the hostname or ip address where the
      *    memcache server runs. This is the only required option.
      *  - 'port': This is the port number of the memcache server. If this
      *    option isn't set, then we will use the 'memcache.default_port'
      *    ini setting. This is 11211 by default.
      *  - 'weight': This sets the weight of this server in this server
      *    group. http://php.net/manual/en/function.Memcache-addServer.php
      *    contains more information about the weight option.
      *  - 'timeout': The timeout for this server. By default, the timeout
      *    is 3 seconds.
      *
      * Example of redundant configuration with load balancing:
      * This configuration makes it possible to lose both servers in the
      * a-group or both servers in the b-group without losing any sessions.
      * Note that sessions will be lost if one server is lost from both the
      * a-group and the b-group.
      *
      * 'memcache_store.servers' => array(
      *     array(
      *         array('hostname' => 'mc_a1'),
      *         array('hostname' => 'mc_a2'),
      *     ),
      *     array(
      *         array('hostname' => 'mc_b1'),
      *         array('hostname' => 'mc_b2'),
      *     ),
      * ),
      *
      * Example of simple configuration with only one memcache server,
      * running on the same computer as the web server:
      * Note that all sessions will be lost if the memcache server crashes.
      *
      * 'memcache_store.servers' => array(
      *     array(
      *         array('hostname' => 'localhost'),
      *     ),
      * ),
      *
      */
      'memcache_store.servers' => array(
          array(
              array('hostname' => 'localhost'),
          ),
      ),


      /*
      * This value allows you to set a prefix for memcache-keys. The default
      * for this value is 'simpleSAMLphp', which is fine in most cases.
      *
      * When running multiple instances of SSP on the same host, and more
      * than one instance is using memcache, you probably want to assign
      * a unique value per instance to this setting to avoid data collision.
      */
      'memcache_store.prefix' => null,


      /*
      * This value is the duration data should be stored in memcache. Data
      * will be dropped from the memcache servers when this time expires.
      * The time will be reset every time the data is written to the
      * memcache servers.
      *
      * This value should always be larger than the 'session.duration'
      * option. Not doing this may result in the session being deleted from
      * the memcache servers while it is still in use.
      *
      * Set this value to 0 if you don't want data to expire.
      *
      * Note: The oldest data will always be deleted if the memcache server
      * runs out of storage space.
      */
      'memcache_store.expires' => 36 * (60 * 60), // 36 hours.


      /*
      * Should signing of generated metadata be enabled by default.
      *
      * Metadata signing can also be enabled for a individual SP or IdP by setting the
      * same option in the metadata for the SP or IdP.
      */
      'metadata.sign.enable' => false,

      /*
      * The default key & certificate which should be used to sign generated metadata. These
      * are files stored in the cert dir.
      * These values can be overridden by the options with the same names in the SP or
      * IdP metadata.
      *
      * If these aren't specified here or in the metadata for the SP or IdP, then
      * the 'certificate' and 'privatekey' option in the metadata will be used.
      * if those aren't set, signing of metadata will fail.
      */
      'metadata.sign.privatekey' => null,
      'metadata.sign.privatekey_pass' => null,
      'metadata.sign.certificate' => null,


      /*
      * Proxy to use for retrieving URLs.
      *
      * Example:
      *   'proxy' => 'tcp://proxy.example.com:5100'
      */
      'proxy' => null,

      /*
      * Array of domains that are allowed when generating links or redirections
      * to URLs. SimpleSAMLphp will use this option to determine whether to
      * to consider a given URL valid or not, but you should always validate
      * URLs obtained from the input on your own (i.e. ReturnTo or RelayState
      * parameters obtained from the $_REQUEST array).
      *
      * SimpleSAMLphp will automatically add your own domain (either by checking
      * it dynamically, or by using the domain defined in the 'baseurlpath'
      * directive, the latter having precedence) to the list of trusted domains,
      * in case this option is NOT set to NULL. In that case, you are explicitly
      * telling SimpleSAMLphp to verify URLs.
      *
      * Set to an empty array to disallow ALL redirections or links pointing to
      * an external URL other than your own domain. This is the default behaviour.
      *
      * Set to NULL to disable checking of URLs. DO NOT DO THIS UNLESS YOU KNOW
      * WHAT YOU ARE DOING!
      *
      * Example:
      *   'trusted.url.domains' => array('sp.example.com', 'app.example.com'),
      */
      'trusted.url.domains' => array('localhost','localhost:39999', '127.0.0.1'),

      );

    ''; #'
 
    extraConfig =
      ''
      Alias ${config.proxyOptions.path}/simplesaml ${SimpleSAMLphp}/www
      ${"Alias ${config.proxyOptions.path} ${documentRoot}"}

      <Directory ${documentRoot}>
          ${allGranted}
          Options FollowSymLinks 
          DirectoryIndex index.php
      </Directory>   

      SetEnv SIMPLESAMLPHP_CONFIG_DIR ${SimpleSAMLphp}/config

      <Directory ${SimpleSAMLphp}/www>
          ${allGranted}
          Options FollowSymLinks 
          DirectoryIndex index.php
      </Directory>
    ''; 
      
    documentRoot = fileSenderRoot + "/www"; 
    fileSenderRoot = pkgs.stdenv.mkDerivation rec {
      name= "filesender-1.6.1";
      src = pkgs.fetchurl {
        url = "https://downloads.filesender.org/${name}.tar.gz";
        sha256 = "1sjxhf31iwdh0nxrvpi5ygg3ynsbj0c89w9zdg6p2jgivxhgn042";
      };
      installPhase = ''
        mkdir -p $out/config
        cp -r * $out
        
        cp ${filesenderConfig} $out/config/config.php
        #ln -s ${SimpleSAMLphp} $out/www/simplesaml
        ln -s ${SimpleSAMLphp} $out/simplesaml
      '';
    };
     
    SimpleSAMLphp = pkgs.stdenv.mkDerivation rec {
      name = "simplesamlphp-${version}";
      version="1.14.11";
      sha256 ="0y58lcy643a7c6ga1iy2lzvw19xk0pkfzl4dpygssrv9wvlcm6a8";
#       version="1.12.0";
#       sha256 ="1qk195xbr7sa5ncvdxsw5mzr0aby5k7azbg32wpvqs514lcipiac";
      src = pkgs.fetchurl {
        url = "https://github.com/simplesamlphp/simplesamlphp/releases/download/v${version}/${name}.tar.gz";
        inherit sha256;
      };
      installPhase = ''
        mkdir -p $out
        cp -r config-templates/*.php config/
        cp -r metadata-templates/*.php metadata/
        rm -Rf config-templates metadata-templates
        
        rm config/config.php
        cp ${simplesamlConfig} config/config.php
        
        cp -r * $out
      '';
    };
    webserver.enablePHP = true;
    
    # FIXME: factor this into a config.database set which will introduce this dependency upon usage
    extraServiceDependencies = [ "postgresq.service" ];
   
    startupScript = (optionalString (config.dbType == "postgres" && config.dbServer == "") ''
      # FIXME: Reset the database during development
      #${pkgs.postgresql}/bin/dropdb ${config.dbName}

      # Initialise the database automagically
      if ! ${pkgs.postgresql}/bin/psql ${config.dbName} -c '\q' 2>&1; then
        echo "database ${config.dbName} exists"
        ${pkgs.postgresql}/bin/createuser --no-superuser --no-createdb --no-createrole "${config.dbUser}" || true
        ${pkgs.postgresql}/bin/createdb -E UTF8 "${config.dbName}" -O "${config.dbUser}"
        ${pkgs.postgresql}/bin/psql -h "${config.dbServer}" "${config.dbName}" ""${config.dbUser}"" < ${fileSenderRoot}/scripts/filesender_db.sql
      fi
    '');
  
    phpOptions = ''
      max_input_time=3600
      upload_max_filesize=2047M
      post_max_size=2146446312
    '';
    
    # FIXME: robotsTxt    
#     webserver.robotsEntries = optionalString (config.proxyOptions.path != "")
#       ''
#         User-agent: *
#         Disallow: ${config.proxyOptions.path}${config.urlPrefix}/
#         Disallow: ${config.proxyOptions.path}/Special:Search
#         Disallow: ${config.proxyOptions.path}/Special:Random
#       '';    
  };
}


