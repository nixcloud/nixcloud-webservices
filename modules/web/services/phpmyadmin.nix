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

    phpmyadminRoot = pkgs.stdenv.mkDerivation rec {
      buildInputs = [ pkgs.unzip ];
      name="phpmyadmin-${rev}";
      rev="4.6.6-all-languages";
      src = pkgs.fetchurl {
        url = "https://files.phpmyadmin.net/phpMyAdmin/4.6.6/phpMyAdmin-4.6.6-all-languages.zip";
        sha256 = "0sidw8ab0g15bv2f5svj84gp541qzkpnqchavpzhljbc5wqdn1lq";
      };

      unpackPhase = ''
        unzip $src
        cd phpMyAdmin-*
      '';
      installPhase = ''
        mkdir -p $out
        cp -r * $out
      '';
    };
    extraConfig = ''
      DocumentRoot ${phpmyadminRoot}
        
      Alias ${config.proxyOptions.path} ${phpmyadminRoot}
      
      <Directory ${phpmyadminRoot}>
        ${allGranted}
        Options FollowSymLinks 
        DirectoryIndex index.php
        AllowOverride All
      </Directory>
    ''; 
  };
}
