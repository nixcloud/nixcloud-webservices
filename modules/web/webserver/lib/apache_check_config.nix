# nixcloud.io configuration checker function for apache

{ pkgs, lib }:
with lib;

let
  #awk -f /tmp/z.awk /tmp/apache.conf
  awkFormat = pkgs.writeText "awkFormat.awk" ''
    awk -f
    {sub(/^[ \t]+/,"");idx=0}
    /\{/{ctx++;idx=1}
    /\}/{ctx--}
    {id="";for(i=idx;i<ctx;i++)id=sprintf("%s%s", id, "\t");printf "%s%s\n", id, $0}
  '';
in rec {
    
  # a hacky way to format the config file & checking it for correct syntax
  checkAndFormatApacheConfigfile = { configFile, fileName ? "apache.conf" }: 
  pkgs.stdenv.mkDerivation {
    name = "apache_check_config";
    src = "";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir $out/
      awk -f ${awkFormat} ${configFile} | sed '/^\s*$/d' > $out/${fileName}
      set +e

      echo "=========== apache config cleanup ==========="
     
      cp $out/${fileName} $out/${fileName}_
      echo "Refining apache configuration so it will pass tests even we don't have directories setup properly."
      echo "   -> $out/${fileName}_ <- file for testing"  
      echo "  Note: during nix-build, with 'nix.useSandbox=true', there won't be any apache specific directories yet!"
      sed -i -E "s|DefaultRuntimeDir .*|DefaultRuntimeDir /tmp|g"  $out/${fileName}_
      sed -i -E "s|ErrorLog .*||g"  $out/${fileName}_
      sed -i -E "s|CustomLog .*||g"  $out/${fileName}_
      sed -i -E "s|User .*||g"  $out/${fileName}_
      sed -i -E "s|Group .*||g"  $out/${fileName}_
      sed -i -E "s|DocumentRoot .*|DocumentRoot /tmp|g"  $out/${fileName}_
      
      echo "=========== /apache config cleanup ==========="
      
      t=$(${pkgs.apacheHttpd}/bin/httpd -t -f $out/${fileName}_ 2>&1) 

      echo $t | grep 'Syntax OK' > /dev/null
      status=$?
      set -e
      
      if [ "$status" != "0" ]; then
        echo "=========== apache syntax check fail ==========="
        echo -e $t
        echo "   -> $out/${fileName}_ <- file for testing"  
        echo "   -> $out/${fileName}"
        echo "=========== /apache syntax check fail ==========="
        echo "You need to fix your apache configuration!!1!"
        exit 1
      else
        echo "=========== apache syntax check ==========="
        echo "syntax is ok! YAY! \o/"
        echo "   -> $out/${fileName}"
        echo "   -> status: $status"
        echo "=========== /apache syntax check ==========="
        rm $out/${fileName}_
      fi
    '';
  };
}      
