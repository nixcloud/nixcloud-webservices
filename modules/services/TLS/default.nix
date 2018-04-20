# roadmap
#
# 1. implement config part:
#    - [done] where "ACME" creates a `security.acme` entry
#    - [done] where "selfsigned" creates a self signed tls certificate
#    - [done] create workflow for supplied certificates
# 2. integrate this into nixcloud-webservices / nixcloud.email
#    - [done] create systemd / service / target dependency 
#    - [done] make nixcloud.TLS.certs."foo" a new option and check it properly / nixcloud.TLS.certs.<name>.mode defaults to "ACME" 
#    - [done] test it with self signed certs
#    - [done] test with usersupplied certs
#    - [done] integrate this into nixcloud.email
# 3. documentation
#    - [done] write documentation
#    - [done] redo all description and examples
# 4. merge this into nixcloud-webservices for nixcloud-webservices and nixcloud.email
#    - [] verify that all scenarious produce correct certificates & systemd dependencies are working and merges are actually working as intended
#    - [] verify that no TLS certificate ends up in the /nix/store
#    - [] merge it
# 5. blog about this new feature and give a short introduction into nix typing
#
# FIXME: blog post:
#  - example: see the https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/misc/meta.nix example
#  - check: if check for custom type fails, one should be able to get a LOC string, where that type
#    was defined and what arguments it wants (as string for instance) and additionally one should
#    be able to supply a custom error message
#        error: The option value `nixcloud.TLS.certs.example.com.mode' in `/home/joachim/Desktop/projects/nixcloud/nixcloud-webservices/modules/services/TLS' is not of type `nixcloudTLSModeType'.
#    - this error message contains a BUG, as it states nixcloud.TLS.certs.example.com.mode instead of nixcloud.TLS.certs."example.com".mode
#    - custom types should have a name close to the type definition. in this example a user seeing this error message will get confused as
#      he does not know what is going on as he can't guess the internals
#    - that is why i hacked the name to be: `name = "nixcloud.TLS.certs.<name>.mode";`
#  - check: in check one uses isString, it would be nice to also be able to use the same syntax as in
#    type = types.string (and similar functions) becase now one has to reimplement basically what we 
#    have in type already
#  - merge: explain `merge = loc: defs: ` with an easy example. especially point out builtins.trace and lib.traceVal usage ...
#  - merge: explain the bool merge vs. the string vs. the str merge (see domain/email option implications)
#  - merge: default values for mkOption(s) don't appear in the merge function arguments
#    - this means one can't easily add a domain name based on the 'submodule' functiosn 'name' argument as it won't appear
#      in the merge when some other module defines it.
#    - it also means that we can't bail out in the 'merge' function with an error: you forgot to define a meaningful value here
#      this is why nixcloud.TLS.certs.<name>'s apply function has assertions for that (hack!)
#  - undefined values: in the option system produce this error:
#    error: The option `nixcloud.TLS.certs.example.com.mode' is used but not defined.
#    but it lacks a context where that 'usage' actually takes place
#  - explain: `apply = ` hack to assert that at last one module set this option
#
# idea: test if the check function can be used with `types.string.check`
#      || (types.string.check x && x == "ACME") 
#       and how this can be done with submodule and similar types
#
# wish: a hook for a custom type which is triggered once all modules have been merged so that
#       one can verify the state of a type before it is actually used
#       we could even call this assert?


{ config, pkgs, lib, ... } @ args:
with lib;

let
  cfg = config.nixcloud.TLS;
  stateDir = "/var/lib/nixcloud/TLS/";
  tls_certificateSetModule = {
    options = {
      tls_certificate = mkOption {
        type = types.path;
        description = ''
          A location containg the full file-path to your TLS certificate as`/path/to/fullchain.pem`.
        '';
        example = "/path/to/fullchain.pem";
      };
      tls_certificate_key = mkOption {
        type = types.path;
        description = ''
          A location containg the full file-path to your TLS key as`/path/to/key.pem`.
        '';
        example = "/path/to/key.pem";
      };
    };
  };
  nixcloudTLSDomainType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.domain";
    check = x: (isString x && x != "") 
      || (isNull x);
    merge = mergeEqualOption;
  };
  nixcloudTLSEmailType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.email";
    check = x: (isString x && x != "") 
      || (isNull x);
    merge = mergeEqualOption;
  };  
  nixcloudTLSModeType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.mode";
    merge = mergeEqualOption;
    check = x: ((isString x && x == "ACME") 
        || (isString x && x == "selfsigned") 
        || ((isAttrs x || isFunction x) && x ? tls_certificate_key && x ? tls_certificate));
  };
  c = x: ((isList x) && fold (el: c: if (isString el) then c else false) true x);
  m = loc: defs: unique (fold (el: c: el.value ++ c) [] defs);
  nixcloudExtraDomainsType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.extraDomains";
    check = c;
    merge = m;
  };
  nixcloudReloadType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.reload";
    check = c;
    merge = m;
  };
  nixcloudRestartType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.restart";
    check = c;
    merge = m;
  };  
  certOpts = { name, ... } @ toplevel: {
    options = {
      domain = mkOption {
        type = nixcloudTLSDomainType;
        default = name;
        description = "Domain to fetch certificate for (defaults to the entry name)";
      };
      extraDomains = mkOption {
        type = nixcloudExtraDomainsType;
        default = [];
        example = literalExample ''
          [ "example.org" "mydomain.org" ];
        '';
        apply = x: unique x;
        description = ''
          A list of extra domain names, which are included in the one certificate to be issued.
        '';
      };
      reload = mkOption {
        type = nixcloudReloadType;
        apply = x: lib.subtractLists toplevel.config.restart (unique x);
        default = [];
        example = [ "postifx.service" ];
        description = ''
          A list of systemd services which are `reloaded` after certificates are re-issued.
          A service is only `reloaded` once, even when mentioned serveral times in this list.
          It is not reloaded if it is also listed in the `restart` list, then it is only restarted.
        '';
      };    
      restart = mkOption {
        type = nixcloudRestartType;
        default = [];
        apply = x: unique x;
        example = [ "postifx.service" ];
        description = ''
          A list of systemd services which are `restarted` after certificates are re-issued.
          A service is only `restarted` once, even when mentioned serveral times in this list.
        '';
      };  
      email = mkOption {
        type = nixcloudTLSEmailType;
        default = null;
        description = "Optional contact email address for the let's encrypt CA to be able to reach you when using ACME.";
      };
      mode = mkOption {
        type = nixcloudTLSModeType;
        default = "ACME";
        description = ''
         Use this option to set the `TLS mode` to be used:
        
          * "ACME" - (default) uses let's encrypt to automatically download and install TLS certificates
          * "selfsigned" - will create self-signed certificates
          * { tls_certificate_key = /flux/to/cert.pem; tls_certificate = /flux/to/key.pem; }; - usersupplied certificates
          
          Note: Certificates are copied into /var/lib/nixcloud/TLS and referenced from there since we might introduce differentiated
                user/group permissions on certificates and that won't work with the certificate is located in /root or some other
                place not managed by `nixcloud.TLS`.
      ''; #'
 
      };
      tls_certificate_key = mkOption {
        type = types.path;
        readOnly = true;
        default = 
          if (isString toplevel.config.mode) then 
            if (toplevel.config.mode == "ACME") then "/var/lib/acme/${name}/key.pem" else 
            if (toplevel.config.mode == "selfsigned") then "/var/lib/nixcloud/TLS/${name}/selfsigned/key.pem" else
            "/undefined1"
          else if (isAttrs toplevel.config.mode) then "/var/lib/nixcloud/TLS/${name}/usersupplied/key.pem" else
            "/undefined2";
        description = "Internally set option (read only) which points to the `key.pem` file, depending on the `nixcloud.TLS.certs.<name>.mode` setting.";
      };
      tls_certificate = mkOption {
        type = types.path;
        readOnly = true;
        default = 
          if (isString toplevel.config.mode) then 
            if (toplevel.config.mode == "ACME") then "/var/lib/acme/${name}/fullchain.pem" else 
            if (toplevel.config.mode == "selfsigned") then "/var/lib/nixcloud/TLS/${name}/selfsigned/fullchain.pem" else
            "/undefined1_"
          else if (isAttrs toplevel.config.mode) then "/var/lib/nixcloud/TLS/${name}/usersupplied/fullchain.pem" else
            "/undefined2_";
        description = "Internally set option (read only) which points to the `fullchain.pem` file, depending on the `nixcloud.TLS.certs.<name>.mode` setting.";
      };        
    };
  };
in

{
  options = {
    nixcloud.TLS = {
      certs = mkOption {
        default = {};
        type = types.attrsOf (types.submodule certOpts);
        description = ''
          Attribute set of certificates to be used by various NixOS services.
        '';
        example = literalExample ''
          "example.com" = {
            email = "foo@example.com";
            reload = [ "postifx.service" "myservice.service" ];
          };
        '';
      };
    };
  };
  
  config = 
    let
      usersuppliedTargets = (fold (cert: con: if (isAttrs (config.nixcloud.TLS.certs.${cert}.mode)) then con ++ [
      (nameValuePair "nixcloud.TLS-usersupplied-${cert}" (
        let 
          c = config.nixcloud.TLS.certs.${cert};
          tls_certificate =     c.mode.tls_certificate;
          tls_certificate_key = c.mode.tls_certificate_key;
        in {
          description = "nixcloud.TLS: create usersupplied certificate for ${cert}";

          script = ''
            rm -Rf /var/lib/nixcloud/TLS/${cert}/usersupplied # should not be needed
            TMPDIR=$(mktemp -d usersupplied-${cert}.XXXXXXXXXX --tmpdir)
            mkdir $TMPDIR/usersupplied
            
            cp ${toString tls_certificate_key} $TMPDIR/usersupplied/key.pem
            cp ${toString tls_certificate} $TMPDIR/usersupplied/fullchain.pem
            
            chmod 0700 $TMPDIR/usersupplied
            mkdir -p ${stateDir}/${cert}/
            mv $TMPDIR/usersupplied /var/lib/nixcloud/TLS/${cert}/
          '';
          serviceConfig = {
            Type = "oneshot";
            RuntimeDirectory = "nixcloud.TLS-acme-usersupplied-${cert}";
          };
          before = [
            "nixcloud.TLS-usersupplied-certificates.target"
          ];
          wantedBy = [
            "nixcloud.TLS-usersupplied-certificates.target" "multi-user.target"
          ];
        }))
      ] else con) [] (attrNames config.nixcloud.TLS.certs)); 
  
      selfsignedTargets = (fold (cert: con: if ((config.nixcloud.TLS.certs.${cert}.mode) == "selfsigned") then con ++ [
        (nameValuePair "nixcloud.TLS-selfsigned-${cert}" (
          let 
            c = config.nixcloud.TLS.certs.${cert}; 
          in {
            description = "nixcloud.TLS: create preliminary self-signed certificate for ${cert}";

            script = ''
              rm -Rf /var/lib/nixcloud/TLS/${cert}/selfsigned # should not be needed
              TMPDIR=$(mktemp -d selfsigned-${cert}.XXXXXXXXXX --tmpdir)
              mkdir $TMPDIR/selfsigned
              
              # Create self-signed key
              workdir=$(mktemp -d selfsigned-${cert}.XXXXXXXXXX --tmpdir)
              ${pkgs.openssl.bin}/bin/openssl genrsa -des3 -passout pass:x -out $workdir/server.pass.key 2048
              ${pkgs.openssl.bin}/bin/openssl rsa -passin pass:x -in $workdir/server.pass.key -out $workdir/server.key
              ${pkgs.openssl.bin}/bin/openssl req -new -key $workdir/server.key -out $workdir/server.csr \
                -subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=example.com"
              ${pkgs.openssl.bin}/bin/openssl x509 -req -days 1 -in $workdir/server.csr -signkey $workdir/server.key -out $workdir/server.crt
              # Move key to destination
              mv $workdir/server.key $TMPDIR/selfsigned/key.pem
              mv $workdir/server.crt $TMPDIR/selfsigned/fullchain.pem
              
              chmod 0700 $TMPDIR/selfsigned
              mkdir -p ${stateDir}/${cert}/
              mv $TMPDIR/selfsigned /var/lib/nixcloud/TLS/${cert}/
            '';
            serviceConfig = {
              Type = "oneshot";
              RuntimeDirectory = "nixcloud.TLS-acme-selfsigned-${cert}";
            };
            unitConfig = {
              # Do not create self-signed key when key already exists
              ConditionPathExists = "!/var/lib/nixcloud/TLS/${cert}/selfsigned";
            };
            before = [
              "nixcloud.TLS-selfsigned-certificates.target"
            ];
            wantedBy = [
              "nixcloud.TLS-selfsigned-certificates.target" "multi-user.target"
            ];
          }))
      ] else con) [] (attrNames config.nixcloud.TLS.certs));      
      
      nixcloudTLSService = nameValuePair "nixcloud.TLS" (
        {
          description   = "nixcloud.TLS service (managing TLS certificates)";
          
          wantedBy = [ "multi-user.target" ];
          after    = [ "network.target" ] ;
          wants    = [];
          
          preStart = ''
            mkdir -p   ${stateDir}
            chmod 0755 ${stateDir}
          '';
          serviceConfig = {
            ExecStart = "${pkgs.bash}/bin/bash -c 'exit 0;'";
            RemainAfterExit=true;
          };
        });
    in {
      security.acme.certs = (fold (cert: con: if ((config.nixcloud.TLS.certs.${cert}.mode) == "ACME") then con // {
        "${cert}" = let c = config.nixcloud.TLS.certs.${cert}; in {
          domain = "${c.domain}";
          email = c.email;
          webroot = "/var/lib/acme/acme-challenges";
          postRun = ''
          ${lib.concatStringsSep "\n" (map (el: "  systemctl restart ${el}") c.restart)}
          ${lib.concatStringsSep "\n" (map (el: "  systemctl reload ${el}") c.reload)}
          '';
        };
      } else con) {} (attrNames config.nixcloud.TLS.certs));
    
      systemd.services = listToAttrs ([ nixcloudTLSService ] ++ selfsignedTargets ++ usersuppliedTargets);
      
      systemd.targets."nixcloud.TLS-usersupplied-certificates" = {
        description   = "If reached, all certificates, which were supplied by the user, were already copied in place to be used";
      };
      systemd.targets."nixcloud.TLS-selfsigned-certificates" = {
        description   = "If reached, all self-signed certificates, which were automatically created, were already copied in place to be used";
      };
 
      systemd.targets."nixcloud.TLS-certificates" = {
        description   = "If reached, all certificates managed via nixcloud.TLS have been put into place to be used";
        
        after = [ "acme-selfsigned-certificates.target" ] # security.acme
             ++ [ "acme-certificates.target" ]            # security.acme
             ++ [ "nixcloud.TLS-usersupplied-certificates.target" ]
             ++ [ "nixcloud.TLS-selfsigned-certificates.target" ];                                
      };
    meta = {
      maintainers = with lib.maintainers; [ qknight ];
    };
  };
}

     
