# https://trello.com/c/dHSQhPYx/180-nixcloudtls

{ config, pkgs, lib, ... } @ args:

with lib;

let
  cfg = config.nixcloud.TLS;
  ssl_certificateSetModule = {
    options = {
      ssl_certificate = mkOption {
        type = types.path;
        description = ''
          A location containg the full path and filename to `/path/to/fullchain.pem`.
        '';
        example = "/path/to/fullchain.pem";
      };
      ssl_certificate_key = mkOption {
        type = types.path;
        description = ''
          A location containg the full path and filename to `/path/to/key.pem`.
        '';
        example = "/path/to/key.pem";
      };
    };
  };
  
  certOpts = { name, ... } @ toplevel: {
    options = {
      domain = mkOption {
        type = types.str;
        default = name;
        description = "Domain to fetch certificate for (defaults to the entry name)";
      };
      extraDomains = mkOption {
        type = types.attrsOf (types.nullOr types.str);
        default = {};
        example = literalExample ''
          {
            "example.org" = "/srv/http/nginx";
            "mydomain.org" = null;
          }
        '';
        description = ''
          A list of extra domain names, which are included in the one certificate to be issued, with their
          own server roots if needed.
        '';
      };      
      email = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Contact email address for the CA to be able to reach you.";
      };
      mode = mkOption {
        type = types.either (types.enum [ "ACME" "selfsigned" ]) (types.submodule ssl_certificateSetModule);
        default = "ACME";
        description = "";
      };
      ssl_certificate_key = mkOption {
        type = types.path;
        default = if (builtins.typeOf toplevel.config.mode == "string") then 
                    if (toplevel.config.mode == "ACME") then "/var/lib/acme/${name}/tlscert.pem" else "/var/lib/nixcloud/TLS/${name}/tlscert.pem"
                  else 
                    toplevel.config.mode.ssl_certificate_key;
        description = "";
      };
      ssl_certificate = mkOption {
        type = types.path;
        default = if (builtins.typeOf toplevel.config.mode == "string") then 
            if (toplevel.config.mode == "ACME") then "/var/lib/acme/${name}/tlskey.pem" else "/var/lib/nixcloud/TLS/${name}/tlskey.pem"
          else 
            toplevel.config.mode.ssl_certificate_key;
        description = "";
      };
      services = mkOption {
        description = "associated systemd services to perform actions over";
        default = {};
        example = literalExample ''
          {
            postfix.action = "restart";
            dovecot.action = "reload";
          };
        '';
        type = types.attrsOf (types.submodule {
          options = {
            action = mkOption {
              type = enum [ "restart" "reload" ];
              default = null;
              description = ''
                An action to execute on systemd services after certificates are re-issues.
              '';
            };
          };
        });      
      };
    };
  };
in

{
  options = {
    nixcloud.TLS = {
      certs = mkOption {
        default = {
          "example.com" = {
            #email = "foo@example.com";
            #mode = "selfsigned";
            mode = {
              ssl_certificate_key = /path/to/cert.pem;
              ssl_certificate = /path/to/key.pem;
            };
            extraDomains = { "www.example.com" = null; "foo.example.com" = "/var/www/foo/"; };
          };
        };
        type = with types; attrsOf (submodule certOpts);
        description = ''
          Attribute set of certificates to get signed and renewed.
        '';
        example = literalExample ''
          {
            "example.com" = {
              email = "foo@example.com";
              extraDomains = { "www.example.com" = null; "foo.example.com" = "/var/www/foo/"; };
            };
            "bar.example.com" = {
              email = "bar@example.com";
            };
          }
        '';
      };
    };
  };

  config = let
#     selfsignedService = {
#       description = "Create preliminary self-signed certificate for ${cert}";
#       preStart = ''
#           if [ ! -d '${cpath}' ]
#           then
#             mkdir -p '${cpath}'
#             chmod ${rights} '${cpath}'
#             chown '${data.user}:${data.group}' '${cpath}'
#           fi
#       '';
#       script = 
#         ''
#           # Create self-signed key
#           workdir="/run/acme-selfsigned-${cert}"
#           ${pkgs.openssl.bin}/bin/openssl genrsa -des3 -passout pass:x -out $workdir/server.pass.key 2048
#           ${pkgs.openssl.bin}/bin/openssl rsa -passin pass:x -in $workdir/server.pass.key -out $workdir/server.key
#           ${pkgs.openssl.bin}/bin/openssl req -new -key $workdir/server.key -out $workdir/server.csr \
#             -subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=example.com"
#           ${pkgs.openssl.bin}/bin/openssl x509 -req -days 1 -in $workdir/server.csr -signkey $workdir/server.key -out $workdir/server.crt
#           # Move key to destination
#           mv $workdir/server.key ${cpath}/key.pem
#           mv $workdir/server.crt ${cpath}/fullchain.pem
#           # Create full.pem for e.g. lighttpd (same format as "simp_le ... -f full.pem" creates)
#           cat "${cpath}/key.pem" "${cpath}/fullchain.pem" > "${cpath}/full.pem"
#           # Clean up working directory
#           rm $workdir/server.csr
#           rm $workdir/server.pass.key
#           # Give key acme permissions
#           chmod ${rights} '${cpath}/key.pem'
#           chown '${data.user}:${data.group}' '${cpath}/key.pem'
#           chmod ${rights} '${cpath}/fullchain.pem'
#           chown '${data.user}:${data.group}' '${cpath}/fullchain.pem'
#           chmod ${rights} '${cpath}/full.pem'
#           chown '${data.user}:${data.group}' '${cpath}/full.pem'
#         '';
#       serviceConfig = {
#         Type = "oneshot";
#         RuntimeDirectory = "acme-selfsigned-${cert}";
#         PermissionsStartOnly = true;
#         User = data.user;
#         Group = data.group;
#       };
#       unitConfig = {
#         # Do not create self-signed key when key already exists
#         ConditionPathExists = "!${cpath}/key.pem";
#       };
#       before = [
#         "acme-selfsigned-certificates.target"
#       ];
#       wantedBy = [
#         "acme-selfsigned-certificates.target"
#       ];
#     };
  in {
#     security.acme.certs = (fold (el: con: if ((ACMEsupportSet.${el}) == "ACME") then con // {
#       "${el}_ncws" = {
#         domain = "${el}";
#         webroot = "/var/lib/acme/acme-challenges";
#         postRun = ''
#          systemctl reload nixcloud.TLS
#         '';
#       };
#     } else con) {} (attrNames ACMEsupportSet));
  };
  meta = {
    maintainers = with lib.maintainers; [ qknight ];
  };
  #nixcloud.tests.wanted = [ ./test.nix ];
}


 
# # motivation
# 
# nixcloud.TLS - an abstraction to configure TLS with ease
# 
# # links
# https://github.com/NixOS/nixpkgs/pull/34388
# 
# https://github.com/NixOS/nixpkgs/blob/release-18.03/nixos/modules/security/acme.nix
# 
# # requirements
# 
# * merging of certificate requirements: if several different services like nixcloud.reverse-proxy and nixcloud.email are configured for the same domain, then `reload/restart` the merged list of dependencies
# * supported modes
#         * "selfsigned"
#         * "ACME"
#         * {ssl_certificate_key = ./path/key.pem; ssl_certificate = ./path/cert.pem }
# * reverse-proxy / nixcloud.email must wait until targets are ready, so 
#         nixcloud.TLS."nixcloud.io".systemd.before
#         nixcloud.TLS."nixcloud.io".systemd.wantedBy
# 
# # usage examples

## von irgendwo:

# nixcloud.TLS."example.com123" = {
#   domain = "example.com";
#   mode = "selfsigned";
# };
# 
# nixcloud.TLS."example.org" = {
#   mode = {
#     ssl_certificate_key = /path/to/cert.pem;
#     ssl_certificate = /path/to/key.pem;
#   };
# };
# 
# nixcloud.TLS."nixcloud.io".services =
#   {
#     postfix.action = "restart";
#     dovecot.action = "reload";
#   };
#   
# # später dann (um den merge zu zeigen):
# 
# nixcloud.TLS."nixcloud.io".services =
#   {
#     "nixcloud.reverse-proxy".action = "reload";
#   };
#   
# # when using the cert location:
# 
# config.nixcloud.TLS."nixcloud.io".ssl_certificate -> /path/to/cert.pem
# config.nixcloud.TLS."nixcloud.io".ssl_certificate_key -> /path/to/key.pem
# 
# # oder auch folgende idee:
# 
#   nixcloud.webservices.leaps.z2 = {
#     enable = true;
#     proxyOptions = {
#       port = 3031;
#       http.mode = "on";
#       https.mode = "on";
#       path = "/flubber99";
#       domain = "example22.com";
#       # mit eigenem cert
#       TLS = {
#         ssl_certificate_key = /path/to/cert.pem;
#         ssl_certificate = /path/to/key.pem;
#       };
#       # klassisch
#       TLS = "ACME"; 
#       # ist das ne gute syntax?
#       TLS = nixcloud.TLS."example22.com";
#       # paul: wir nutzen immer nixcloud.TLS und übergeben nur den identifier
#       TLS = "example22.com";
#     };
#   };
# 
