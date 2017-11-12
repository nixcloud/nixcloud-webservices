{ config, options, lib, pkgs, wsName, ... }:

with lib; 

{
  options = {
    extraCaldavZAPConfig = mkOption {
      example = 
        '' 
        var globalSubscribedCalendars={
          hrefLabel: 'Subscribed',
          calendars: [
            {
              href: 'http://something.com/calendar.ics',
              userAuth: {
                userName: ''',
                userPassword: '''
              },
              typeList: ['vevent', 'vtodo'],
              ignoreAlarm: true,
              displayName: 'Remote Calendar 1',
              color: '#ff0000'
            }
          ]
        };
      '';
      default = "";
      type = types.str;
      description = "Extra configuration lines which are appended to `config.js`";
    };
  };

  config = let
    # FIXME: refactor this many lines (also found in other webservices) into something small and useful
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

    caldavZAPRoot = pkgs.stdenv.mkDerivation rec {
      name = "CalDavZAP-0.13.1";
      src = pkgs.fetchurl {
        url = "https://www.inf-it.com/CalDavZAP_0.13.1.zip";
        sha256 = "1pjdg7rb8y53w857f8x96jd69xjj13b0f9187zbvz6f6hm7pmdhz";
      };
      buildInputs = [ pkgs.unzip pkgs.ed ];
      
      unpackPhase = ''
        unzip $src
        cd caldavzap
      '';
      
      buildPhase = ''
        # FIXME SECURITY writing password/username into the store!
        cat >> config.js <<- EOF
        ${config.extraCaldavZAPConfig}
        EOF
        # updated the manifest -> sh cache_update.sh
        command -v ed &> /dev/null || { echo "Error: 'ed' not installed. Aborting." >&2; exit 1; }
        printf ",s/#V.*/#V $(date '+%Y%m%d%H%M%S')/\nw\nq\n" | ed -s cache.manifest
      '';
      
      installPhase = ''
        mkdir $out
        cp -r * $out
      '';
    };

    extraConfig = ''
      Alias ${config.proxyOptions.path} ${caldavZAPRoot}/
      
      <Directory ${caldavZAPRoot}/>
        ${allGranted}
        AllowOverride All
      </Directory>   
    ''; 
  };

  meta = {
    description = "CalDAV web client implementation JavaScript + jQuery";
    maintainers = with maintainers; [ qknight ];
    license = licenses.agpl3;
    homepage = https://www.inf-it.com/open-source/clients/caldavzap/;
  };
}
