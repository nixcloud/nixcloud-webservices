{ config, lib, pkgs, apache, mkUniqueUser, mkUniqueGroup, ... }:

with lib;
let
  roundcubeConfigFile = pkgs.writeText "config.inc.php" ''
    <?php
    $config = array(
      'db_dsnw' => 'sqlite:///${config.stateDir}/roundcube/sqlite.db?mode=0600',
      'log_dir' => '${config.stateDir}/log',
      'enable_spellcheck' => ${if config.config.enable_spellcheck then "True" else "False"},
    );
    ${config.extraConfig}
  '';
in
{
  options = {
    config = {
      enable_spellcheck = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable spellchecking when composing mails
          WARNING: Due to possible privacy implications when using an online spellchecking
          service this function is disabled by default.
        '';
      };
      spellcheck_engine = mkOption {
        type = types.nullOr (types.enum ["googie" "pspell" "enchant" "atd"]);
        default = null;
        description = ''
          The spellcheck engine to be used.
          WARNING: Some engines might use online services, which has privacy implications.
        '';
      };
    };
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      example = ''
        $config['log_date_format'] = 'd-M-Y H:i:s O';
        $config['imap_timeout']    = 30;
      '';
      description = ''
        Any additional lines to be appended to Roundcube's
        configuration file.
        See the reference documentation:
        <link xlink:href='https://github.com/roundcube/roundcubemail/wiki/Configuration'/>.
      '';
    };
  };

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
