# nixcloud.io configuration checker function for nginx

{ pkgs, lib }:
with lib;

let
  #awk -f /tmp/z.awk /nix/store/nginx.conf
  awkFormat = pkgs.writeText "awkFormat.awk" ''
    awk -f
    {sub(/^[ \t]+/,"");idx=0}
    /\{/{ctx++;idx=1}
    /\}/{ctx--}
    {id="";for(i=idx;i<ctx;i++)id=sprintf("%s%s", id, "\t");printf "%s%s\n", id, $0}
  '';
in rec {
    
  # a hacky way to format the config file & checking it for correct syntax
  checkAndFormatNginxConfigfile = { configFile, fileName ? "nginx.conf" }: 
  pkgs.stdenv.mkDerivation {
    name = "nginx_check_config";
    src = "";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir $out/
      awk -f ${awkFormat} ${configFile} | sed '/^\s*$/d' > $out/${fileName}
      
      # this checks if the config is sane
      touch nginx.pid
      
      # nginx -t requires certificates to be there! we don't have certificates, even snaikoil ones which are created by ACME, before service startup!
      # so this smart code, borrowed from fpletz, will create one
      echo "------------ generating fake certificates for nginx syntax check ---------------"
      workdir=./
      ${pkgs.openssl.bin}/bin/openssl genrsa -des3 -passout pass:xxxx -out $workdir/server.pass.key 2048
      ${pkgs.openssl.bin}/bin/openssl rsa -passin pass:xxxx -in $workdir/server.pass.key -out $workdir/server.key
      ${pkgs.openssl.bin}/bin/openssl req -new -key $workdir/server.key -out $workdir/server.csr \
        -subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=example.com"
      ${pkgs.openssl.bin}/bin/openssl x509 -req -days 1 -in $workdir/server.csr -signkey $workdir/server.key -out $workdir/server.crt

      # Move key to destination
      mv $workdir/server.key nginx_generated_testing_key.pem
      mv $workdir/server.crt nginx_generated_testing_fullchain.pem
      
      cp *.key *.pem $out/
      
      cp $out/${fileName} $out/${fileName}_
      sed -i -E "s|ssl_certificate .*;|ssl_certificate ./nginx_generated_testing_fullchain.pem;|g"  $out/${fileName}_
      sed -i -E "s|ssl_certificate_key.*;|ssl_certificate_key ./nginx_generated_testing_key.pem;|g" $out/${fileName}_
      echo "------------ /generating fake certificates for nginx syntax check ---------------"
      
      # using 'set +e' here since nginx not only checks the syntax but executes the webserver which always fails
      # as the environment isn't and can't be setup propperly at this stage.
      # checking the syntax is already a huge gain as we see these errors during nix-evaluation and don't have to
      # deploy with a broken configuration file in order to see it 'fail'.
      set +e
      t=$(${pkgs.nginx}/bin/nginx -t -c $out/${fileName}_ -g "pid nginx.pid; worker_processes 2; " 2>&1)
      echo $t | grep 'syntax is ok'
      status=$?
      set -e
      
      if [ "$status" != "0" ]; then
        echo "=========== nginx syntax check fail ==========="
        echo -e "$t"
        echo "   -> $out/${fileName}"
        echo "=========== /nginx syntax check fail ==========="
        echo "You need to fix your nginx configuration!!1!"
        exit 1
      else
        echo "=========== nginx syntax check ==========="
        echo "syntax is ok! YAY! \o/"
        echo "   -> $out/${fileName}"
        echo "=========== /nginx syntax check ==========="
        rm $out/${fileName}_
        rm $out/nginx_generated_testing_key.pem
        rm $out/nginx_generated_testing_fullchain.pem
        rm $out/server.pass.key
      fi
    '';
  };
}
