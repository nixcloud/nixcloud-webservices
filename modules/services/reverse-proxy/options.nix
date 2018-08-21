{ lib, options, config, name, ... } @ toplevel:

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

  subpath = mkOption {
    type = types.str;
    apply = checkPath;
    description = ''
      The 'subpath' is actually a subdirectory in the URL and the `path` variable from the proxyOption is prepended.
      A subpath must start with a leading "/" and may not have white spaces or a trailing "/" in it.
    '';
  };

  extraFlags = mkOption {
    description = ''
      Use `extraFlags` to add additional headers to requests from the nixcloud.reverse-proxy to the internal webserver.
    '';
    default = "";
    example = ''
      add_header Strict-Transport-Security max-age=345678;
    '';
  };

  extraServerFlags = mkOption {
    description = ''
      Use `extraServerFlags` to add additional flags in the server record from the nixcloud.reverse-proxy. Since there is no 
      collision detection for this option use extraFlags whenever possible instead.
    '';
    default = "";
    example = ''
      large_client_header_buffers 4 32k;
    '';
  };

  record = mkOption {
    description = ''
      The 'location' can be used to override the default location record.
      If this option is used the flags and extraflags options are ignored.
      Ip and Port can be accessed in this record via '$targetIP' and '$targetPort'.
    '';
    default = "";
  };

  locationWebSocketModule = {
    options = {
      port = mkOption {
        type = types.int;
        example = 8080;
        description = ''
          'inet' socket port number (default: inherited from proxyOptions.port) used when creating a nginx location.
        '';
      };
      inherit subpath;
      http = {
        mode = mkOption {
          type = types.enum [ "redirect_to_https" "on" "off" ];
          example = "on";
          description = ''
            Using TLS, thus 443, is the default for websockets of webapps on nixcloud.io.
            Note: setting this to 'redirect_to_https' has the same effect as 'off'.
          '';
        };
        flags = mkOption {
          description = ''
            Use `http.flags` with websockets to add headers to requests from the nixcloud.reverse-proxy to the internal webserver.
            
            $targetIP and $targetPort will be set to the respective values of your `proxyOptions` definition.
          '';
          default = ''
            # http websocket default flags
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header X-Forwarded-For $remote_addr;
            proxy_read_timeout 36000s;
            # required because of CORS
            proxy_set_header Host $host;
            proxy_pass http://$targetIP:$targetPort$request_uri;
          '';
        };
        inherit record;
        inherit basicAuth;
        inherit extraFlags;
      };
      https = {
        mode = mkOption {
          type = types.enum [ "redirect_to_http" "on" "off" ];
          example = "off";
          description = ''
            Using TLS, thus 443, is the default for websockets of webapps on nixcloud.io.
            Note: setting this to 'redirect_to_http' has the same effect as 'off'.
          '';
        };
        flags = mkOption {
          description = ''
            Use `https.flags` with websockets to add headers to requests from the nixcloud.reverse-proxy to the internal webserver.
            
            $targetIP and $targetPort will be set to the respective values of your `proxyOptions` definition.
          '';
          default = ''
            # https websocket default flags
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header X-Forwarded-For $remote_addr;
            proxy_read_timeout 36000s;
            # required because of CORS
            proxy_set_header Host $host;
            proxy_pass http://$targetIP:$targetPort$request_uri;
          '';
        };
        inherit record;
        inherit basicAuth;
        inherit extraFlags;
      };
    };
  };
  extraLocationsModule = {
    options = {
      port = mkOption {
        type = types.int;
        example = 8080;
        description = ''
          'inet' socket port number (default: inherited from proxyOptions.port) used when creating a nginx location.
        '';
      };
      ip = mkOption {
        type = types.str;
        example = "1.2.3.4";
        description = ''
          The default is inherited from proxyOptions.ip but in case the ip for this extraLocations differs you can also point to a IP from a private network like "10.0.0.49".
        '';
      };
      inherit subpath;
      http = {
        mode = mkOption {
          type = types.enum [ "redirect_to_https" "on" "off" ];
          example = "on";
          description = ''
            Using TLS, thus 443, is the default for websockets of webapps on nixcloud.io.
          '';
        };
        flags = mkOption {
          description = ''
            Use `http.flags` to add headers to requests from the nixcloud.reverse-proxy to the internal webserver.
            
            $targetIP and $targetPort will be set to the respective values of your `proxyOptions` definition.
          '';
          default = ''
              # http default flags
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_pass http://$targetIP:$targetPort$request_uri;
          '';
        };
        inherit record;
        inherit basicAuth;
        inherit extraFlags;
      };
      https = {
        mode = mkOption {
          type = types.enum [ "redirect_to_http" "on" "off" ];
          example = "off";
          description = ''
            Using TLS, thus 443, is the default for webapps on nixcloud.io.
          '';
        };
        flags = mkOption {
          description = ''
            Use `https.flags` to add headers to requests from the nixcloud.reverse-proxy to the internal webserver.
            
            $targetIP and $targetPort will be set to the respective values of your `proxyOptions` definition.
          '';
          default = ''
              # https default flags
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_pass http://$targetIP:$targetPort$request_uri;
          '';
        };
        inherit record;
        inherit basicAuth;
        inherit extraFlags;                        
      };
    };
  };
  containsSpace = str: ! (builtins.replaceStrings [" "] ["a"] str == str);
  checkPath = path:
    assert (builtins.substring 0 1 path == "/") || abort "'${path}' lacks leading '/'!";
    assert (!(containsSpace path)) || abort "path: '${path}' contains space(es)!";
    path;

  passthruToplevel = {
    ip = lib.mkDefault config.ip;
    http.mode = lib.mkDefault config.http.mode;
    https.mode = lib.mkDefault config.https.mode;
  } // lib.optionalAttrs options.port.isDefined {
    port = lib.mkDefault config.port;
  };

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
        A subpath must start with a leading "/" and may not have white spaces in it.
        Note that the presence of a trailing slash affects the behaviour of the route matcher.
      '';
    };
    extraLocations = mkOption {
      type = types.attrsOf (types.submodule [
        extraLocationsModule passthruToplevel
      ]);
      default = { };
      example = ''
        extraLocations = {
          api = {
            subpath = "/api";
            port = "8080";
          };
        };
      '';
      description = ''
        The `locations` option holds all your 'location' records. The 'root' location is the main location which must be set. All other locations are subdirectories of the 'root' location and are optional.
      '';
    };
    websockets = mkOption {
      type = types.attrsOf (types.submodule [
        locationWebSocketModule passthruToplevel
      ]);
      default = { };
      example = ''
        websockets = {
          ws = {
            subpath = "/ws";
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
        'inet' socket port number used when creating a nginx location.
      '';
    };
    TLS = mkOption {
      type = types.string;
      apply = x: assert (x != "ACME") || abort "Your proxyOptions.TLS or extraMappings.TLS definition was \"ACME\" but the changed implementation for proxyOptions expects now a nixcloud.TLS.certs identifier instead. \nEither\n * remove the TLS definition completely and use the default which is probably what you want or\n * select properly defined nixcloud.TLS identifier instead"; x;
      description = ''
        Points to an identifier <replaceable>myconfig</replaceable>, which is
        later used to query
        <option>nixcloud.TLS.certs.<replaceable>myconfig</replaceable></option>
        (<option>proxyOptions.domain</option>) is the default identifier.

        TLS adjustments can be made from
        <option>nixcloud.TLS.certs.<replaceable>myconfig</replaceable></option>
        later one like this:

        <programlisting>
        nixcloud.TLS.certs."myconfig" = {
          mode = "selfsigned";
        };
        </programlisting>
      ''; #'
    } // lib.optionalAttrs toplevel.options.domain.isDefined { # XXX!
      default = toplevel.config.domain;
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
      flags = mkOption {
        description = ''
          Use `http.flags` to add headers to requests from the nixcloud.reverse-proxy to the internal webserver.
          
          $targetIP and $targetPort will be set to the respective values of your `proxyOptions` definition.
        '';
        default = ''
          # http default flags
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_pass http://$targetIP:$targetPort$request_uri;
        '';
      };
      inherit record;
      inherit extraFlags;
      inherit extraServerFlags;
      inherit basicAuth;
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
      flags = mkOption {
        description = ''
          Use `https.flags` to add headers to requests from the nixcloud.reverse-proxy to the internal webserver.
          
          $targetIP and $targetPort will be set to the respective values of your `proxyOptions` definition.
        '';
        default = ''
          # https default flags
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_pass http://$targetIP:$targetPort$request_uri;
        '';
      };
      inherit record;
      inherit extraFlags;
      inherit extraServerFlags;
      inherit basicAuth;
    };
  };
}
