{ config, options, lib, pkgs, wsName, ... }:
# https://www.dokuwiki.org/requirements
# resizing images either the PHP GD extension or Image Magick should be installed.
# safe mode

with lib; 

{
  options = { };

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

    installScript =  pkgs.writeText "install-cmd.php" ''
      <?php
      ob_start();
      include 'install.php';
      ob_end_clean();

      if($argc < 4 || !is_numeric($argv[1]) || !is_numeric($argv[2]) || !is_numeric($argv[3]))
      {
          //echo "Usage: $argv[0] mm dd yyyy\n";
          echo "Commandline installer for dokuwiki by nixcloud\n";
          
          $_REQUEST = array(
              'submit'     => 'true'
          );
          $requestData = array(
              'title'     => 'fluxi',
              'acl'       => '1',
              'superuser' => 'admin',
              'fullname'  => 'admin',
              'email'     => 'js@lastlog.de',
              'password'  => 'pass1000123',
              'confirm'   => 'pass1000123',
              'policy'    => '0',
              'allowreg'  => '0',
              'license'   => 'cc-by-sa'
          );
          
          //echo $requestData['title'] . "\n";
          
          if(! (check_functions() && check_permissions()) ){
              echo "check_functions and check_permissions failed\n";
              #echo '<p>'.$lang['i_problems'].'</p>';
              #print_errors();
              #print_retry();
          } elseif(!check_configs()){
              echo "check_configs failed!\n";
              #echo '<p>'.$lang['i_modified'].'</p>';
              #print_errors();
          } elseif(check_data($requestData)){
              echo "check_functions, check_permissions and check_configs worked\n";
              // check_data has sanitized all input parameters
              if(!store_data($requestData)){
                  echo "store_data failed!\n";
              
                  //echo '<p>'.$lang['i_failure'].'</p>';
                  //print_errors();
              } else {
                  echo "installatin worked!\n";
                  #echo '<p>'.$lang['i_success'].'</p>';
              }
          } else {
              echo "check_data failed -> installation failed\n";
              print_errors();
              //print_form($requestData);
          }
      }
      else
      {
          $pastdate = mktime(0, 0, 0, $argv[1], $argv[2], $argv[3]);
          $diff = time() - $pastdate;
          $days = round($diff/60/60/24);
          echo "$days days since $argv[1]/$argv[2]/$argv[3]\n";
      }
      ?>

    '';
    
    dokuwiki-template-adoradark = pkgs.stdenv.mkDerivation rec {
      name="dokuwiki-template-adoradark-${rev}";
      rev="e903fa0c5d62c782104f051c313da6cb8f358c58";
      
      src = pkgs.fetchgit {
        url = "https://github.com/notconscious/dokuwiki-template-adoradark";
        sha256 = "1ih50r1przdkjas6h7b0hw70ygklhpw8blwx5i16l7qna4sqasvf";
        inherit rev;
      };
      installPhase = ''
        mkdir -p $out
        cp -r * $out
      '';
    };
    
    dokuwikiConfig = pkgs.writeText "local.php" '' 
      <?php
      $conf['title'] = 'fluxi';
      $conf['template'] = 'notconscious-dokuwiki-template-adoradark-e903fa0';
      $conf['license'] = 'cc-by-sa';
      $conf['useacl'] = 1;
      $conf['superuser'] = '@admin';
      $conf['disableactions'] = 'register';
      ?>
    '';

    dokuwikiRoot = pkgs.stdenv.mkDerivation rec {
      name= "dokuwiki";
      buildInputs = [ config.webserver.apache.phpPackage ];
      
      src = pkgs.fetchgit {
        url = "https://github.com/splitbrain/dokuwiki";
        sha256 = "1g2kizh1bjmsbhpwm50zbvhs9lwbc114xf2f5kg56drznli866vf";
        rev = "3291b907fa150cfe27bfaeb5e692b4c9f696779e";  # 
      };
      installPhase = ''
        mkdir -p $out
        ${config.webserver.apache.phpPackage}/bin/php ${installScript}
        rm install.php
        #cp ${installScript} $out/install-cmd.php
        cp -r * $out
        ln -s ${dokuwiki-template-adoradark} $out/lib/tpl/notconscious-dokuwiki-template-adoradark-e903fa0
        rm $out/conf/local.php
        ln -s ${dokuwikiConfig} $out/conf/local.php
      '';
    };
    #conf/local.php:$conf['template'] = 'notconscious-dokuwiki-template-adoradark-e903fa0';

    webserver.enablePHP = true;
    startupScript = ''
      mkdir ${config.stateDir}/www
      cp -R ${dokuwikiRoot}/* ${config.stateDir}/www
      chmod 0777 ${config.stateDir} -R
      chown ${config.user}:${config.group } ${config.stateDir} -R
    '';
    
    extraConfig = ''
      Alias ${config.proxyOptions.path} ${config.stateDir}/www
      
      <Directory ${config.stateDir}/www>
        ${allGranted}
        Options FollowSymLinks 
        DirectoryIndex index.php
        AllowOverride All
      </Directory>   
    ''; 
  };
}


