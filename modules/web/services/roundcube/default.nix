{ config, lib, pkgs, apache, mkUniqueUser, mkUniqueGroup, ... }:

with lib;
let
  roundcubeConfigFile = pkgs.writeText "config.inc.php" ''
    <?php
    $config = array(
      'db_dsnw' => 'sqlite:///${config.stateDir}/roundcube/sqlite.db?mode=0600',
      'log_dir' => '${config.stateDir}/log',
    );
  '';
in
{
  options = {};

  config = let
    version = "1.3.8";
    roundcubeRoot = pkgs.stdenv.mkDerivation rec {
      name= "roundcube-${version}";

      src = pkgs.fetchurl {
        url = "https://github.com/roundcube/roundcubemail/releases/download/${version}/roundcubemail-${version}-complete.tar.gz";
        sha256 = "018djad7ygfl9c9f2l2j42qkg31ml3hs2f01f0dk361zckwk77n4";
      };

      buildPhase = ''
        rm -rf installer
      '';
      installPhase = ''
        mkdir -p $out
        cp -r . $out
        ln -sf ${roundcubeConfigFile} $out/config/config.inc.php
      '';
    };
  in {
    webserver.variant = "apache";
    webserver.systemPackages = [pkgs.php];
    webserver.init = ''
      mkdir -p ${config.stateDir}/roundcube/log
      chown -R ${mkUniqueUser config.webserver.user}:${mkUniqueGroup config.webserver.group} ${config.stateDir}/roundcube
      chmod -R 750 ${config.stateDir}/roundcube
    '';
    webserver.apache.enablePHP = true;
    webserver.apache.extraConfig = ''
      <Directory "${roundcubeRoot}">
        Require all granted
      </Directory>
      <Directory "${roundcubeRoot}/config">
        Require all denied
      </Directory>
      DocumentRoot ${roundcubeRoot}
      DirectoryIndex index.php
    '';
  };

  meta = {
    description = "Open Source Webmail Software";
    maintainers = with maintainers; [ eliasp ];
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
