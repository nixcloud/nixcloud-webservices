{ lib, options, config, name, ... }:

with lib;

let
  basicAuth = mkOption {
    type = types.attrsOf types.str;
    default = {};
    example.user = "password";
    description = ''
      Basic Auth protection for all locations generated as the
      <literal>path</literal> location
      as well all of the <literal>wsPaths</literal> locations.

      See also <link xlink:href="${
        "https://nginx.org/en/docs/http/ngx_http_auth_basic_module.html"
      }" />

      <warning><para>
      This is implemented to store the password in plain text in the Nix
      store.
      </para></warning>
    '';
  };

  locationWebSocketModule = {
    options = {
      subpath = mkOption {
        type = types.str;
        apply = checkPath;
        description = ''
          The 'subpath' is actually a subdirectory in the URL and the `path` variable from the proxyOption is prepended.
          A subpath must start with a leading "/" and may not have white spaces or a trailing "/" in it.
        '';
      };
      http = {
        record = mkOption {
          description = ''
            The http.location can be used to override the default location record for http websocket (ws) usage when `http.mode = "on"` is set.
          '';
          default = "";
          example = 
            ''
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";
              proxy_pass http://${location.ip}:${toString location.port}${location.path};
            '';
        };
        inherit basicAuth;
      };

      https = {
        record = mkOption {
          description = ''
            The https.location can be used to override the default location record for https websocket (wss) usage when `https.mode = "on"` is set.
          '';
          default = "";
          example = 
            ''
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";
              proxy_pass http://${location.ip}:${toString location.port}${location.path};
            '';
        };      
        inherit basicAuth;
      };
    };
  };
  containsSpace = str: ! (builtins.replaceStrings [" "] ["a"] str == str);
  checkPath = path:
    assert (builtins.substring 0 1 path == "/") || abort "'${path}' lacks leading '/'!";
    assert (!(containsSpace path)) || abort "path: '${path}' contains space(es)!";
    path;
in

{
  options = {
    domain = mkOption {
      type = types.str;
      example = "example.com";
      description = ''
        The domain for which you want the reverse proxy mapping. If you URL looks like this `https://example.com/wiki` then set domain to "example.com"
      '';
    };
    



    path = mkOption {
      type = types.str;
      default = "/";
      example = "/wiki";
      apply = checkPath;
      description = ''
        The 'subpath' is actually a subdirectory in the URL and the `path` variable from the proxyOption is prepended.
        A subpath must start with a leading "/" and may not have white spaces or a trailing "/" in it.
      '';
    };
    websockets = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule locationWebSocketModule);
      default = { };
      # FIXME: validate this example works
      example = ''
        websockets = {
          ws = {
            subpath = "/leaps/ws";
            https.basicAuth."nixclouduser" = "password_world_readable_in_nix_store";
          };
        };
      '';
      description = ''
        The `locations` option holds all your 'location' records. The 'root' location is the main location which must be set. All other locations, used for WebSockets, are subdirectories of the 'root' location and are optional.
      '';
    };
    ip = mkOption {
      type = types.str;
      example = "1.2.3.4";
      default = "127.0.0.1";
      description = ''
        The default is "127.0.0.1" but in case you are using LXC/Docker you can also point to a IP from a private network like "10.0.0.49".
      '';
    };
    port = mkOption {
      type = types.int;
      example = 2345;
      description = ''
        'inet' socket port number (default 80) used when creating a nginx location.
      '';
    };
    TLS = mkOption {
      type = types.str;
      default = "ACME";
      description = ''
        TLS backend in use. Currently there is only ACME support but a draft for adding a `set` with
        `ssl_certificate` and `ssl_certificate_key` which points to the filesystem is already in place.
      '';
    };
    http = {
      mode = mkOption {
        type = types.enum [ "redirect_to_https" "on" "off" ];
        example = "off";
        default = "redirect_to_https";
        description = ''
          Redirecting from `http` to `https` seems to be a reasonable default on nixcloud.io. We strongly encourage
          the use of TLS. That said, some legacy webapps might still require http support also.
        '';
      };
      record = mkOption {
        description = ''
          The http.record will generate a default location record for http when `http.mode = "on"` is set.
        '';
        default = "";
        example = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_pass http://${location.ip}:${toString location.port}${location.path};
        '';
      };
      inherit basicAuth;

#           flags = mkOption {
#             proxy_set_header Host $host;
#             proxy_set_header X-Real-IP $remote_addr;
#             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#             proxy_set_header X-Forwarded-Proto $scheme;
#           };
    };
    https = {
      mode = mkOption {
        type = types.enum [ "redirect_to_http" "on" "off" ];
        example = "redirect_to_http";
        default = "on";
        description = ''
          Using TLS, thus 443, is the default for webapps on nixcloud.io but it can also be turned off. This
          makes sense for content like downlaods, which can be cached by forward-proxies like squid for example.
        '';
      };
      record = mkOption {
        description = ''
          The https.record will generate a default location record for https when `https.mode = "on"` is set.
        '';
        default = "";
        example = "";
      };      

      inherit basicAuth;

#           flags = mkOption {
#             proxy_set_header Host $host;
#             proxy_set_header X-Real-IP $remote_addr;
#             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#             proxy_set_header X-Forwarded-Proto $scheme;
#           };
    };
  };
}
