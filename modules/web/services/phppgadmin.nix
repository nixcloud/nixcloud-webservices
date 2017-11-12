{ config, options, lib, pkgs, wsName, ... }:

with lib; 
{
  options = {
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

    webserver.enablePHP = true;

    phppgadminRoot = pkgs.stdenv.mkDerivation rec {
      name="phppgadmin-${rev}";
      rev="5.1";
      src = pkgs.fetchurl {
        url = "mirror://sourceforge/phppgadmin/phpPgAdmin-5.1.tar.bz2";
        sha256 = "1ikfzpp4rnj0bfsl8hgazn005bf2bck2ifa3mfkqspn8p320wica";
      }; 
      installPhase = ''
        mkdir -p $out
        cp -r * $out
      '';
    };
    extraConfig = ''
      DocumentRoot ${phppgadminRoot}
        
      Alias ${config.proxyOptions.path} ${phppgadminRoot}
      
      <Directory ${phppgadminRoot}>
        ${allGranted}
        Options FollowSymLinks 
        DirectoryIndex index.php
        AllowOverride All
      </Directory>
    ''; 
  };
}


