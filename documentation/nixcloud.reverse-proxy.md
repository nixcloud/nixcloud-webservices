# nixcloud.reverse-proxy

The `nixcloud.reverse-proxy` acts as an intermediary to allow multiple webservices to run from the same IP address(es) using the same port (80/443), and mapping these to domain names. `nixcloud.reverse-proxy` is a part of [nixcloud-webservices](https://github.com/nixcloud/nixcloud-webservices) and is based on https://www.nginx.com/.

`nixcloud.reverse-proxy` fully implements `security.acme` certificate handling and transparently handles TLS contexts for the inner webservices. Note: ACME based domains handled by `nixcloud.reverse-proxy` will have a '_ncws' suffix and domains from `nixcloud.email` will have a '_email' suffix in their respective `security.acme.certs.<name>`.

![nixcloud.webservices layout](nixcloud-webservices.svg.png)

See also [../README.md](../README.md).

# Options search (API documentation)

Most documentation should be generated from the source code of the reverse-proxy module, see: 

  * https://nixdoc.io/nixcloud-webservices/index.html

# Usage

To enable the reverse-proxy simply put this into your configuration.nix:

    nixcloud.reverse-proxy = {
      enable = true;
    };
    
The reverse-proxy can be used explicitly using `extraMappings` or implicitly by using `nixcloud.webservices`.

## extraMappings example(s)

Motivations to use `nixcloud.reverse-proxy.extraMappings:

* Mix your legacy webservice, which was not built using `nixcloud.webservices` with services from `nixcloud.webservices`
* Outsource TLS certificate management and TLS handling so you don't have to do this in you webservice 
* Use `nixcloud.reverse-proxy` features:

    * TLS configuration (permitted, prohibited protocol families and so on)
    * connection compression
    * basicAuth

* Manage URL redirects for domains/resources
* Manage websocket redirects

### Example 1: Proxying a legacy webservice (not using `nixcloud.webservices`)

The code below has a few properties:

* redirect all http requests to https
* the reverse-proxy only serves data after basicAuth has been used to authentificate the user
* it will serve documents from `http://127.0.0.1:8081/`.

        nixcloud.reverse-proxy = {
          enable = true;
          extendEtcHosts = true;
          extraMappings = [
            {  
              domain = "example.com";
              path = "/";
              https = {
                mode = "on";
                basicAuth."joachim" = "foo";
                record = ''
                  proxy_set_header Host $host;
                  proxy_set_header X-Real-IP $remote_addr;
                  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                  proxy_set_header X-Forwarded-Proto $scheme;
                  proxy_pass http://127.0.0.1:8081/;
                '';
              };
            }
          ];
        };

### Example 2: URL rewriting

The code below will create a mapping: when you visit http(s)://example.com it will redirect to https://example.org but if you access the https://example.com it will prompt for a password before it gives you the redirect. The username is 'joachim' and the password is 'foo'.

    nixcloud.reverse-proxy = {
      enable = true;
      extendEtcHosts = true;
      extraMappings = [
        {  
          domain = "example.com";
          path = "/";
          http = {
            mode = "on";
            record = ''
              rewrite ^(.*)$ https://example.org permanent;
            '';
          };
          https = {
            mode = "on";
            basicAuth."joachim" = "foo";
            record = ''
              rewrite ^(.*)$ https://example.org permanent;
              add_header Strict-Transport-Security max-age=63646566;
              add_header Content-Security-Policy "default-src 'none';";
            '';
          };
        }
      ];
    };

### Example 3: Exposing Websocket(s) only

This example disables all http/https mappings but adds two websocket mappings:

    nixcloud.reverse-proxy = {
      enable = true;
      extraMappings = [
        {
          domain     = "example.com";
          TLS        = "ACME";
          port       = 3003;
          path       = "/backend";
          http.mode  = "off";
          https.mode = "off";
          websockets = {
            ws = {
              https.mode = "on";
              subpath = "/";
            };
            ws2 = {
              https.mode = "on";
              subpath = "/leaps/ws";
            };
          };
        }
      ];
    };

From the internet one could connect to: wss://example.com/backend/ or wss://example.com/backend/leaps/ws

## nixcloud.webservices example(s)


    nixcloud.reverse-proxy.enable = true;
    
    ...
    
    nixcloud.webservices.mediawiki.test1 = {
      enable = true;
      proxyOptions = {
        TLS = "ACME";
        http.mode = "on";
        https.mode = "on";
        port   = 40001;
        path   = "/wiki";
        domain = "example.org";
      };
    };

When using `nixcloud.webservices` the `nixcloud.reverse-proxy` will automatically collect all the proxyOptions and generate reverse-proxy mappings on Nix evaluation time.

The `leaps` webservice sets the websocket binding from the service itself:

    # inject the leaps websocket for cooperative document opening/editing into proxyOptions
    proxyOptions.websockets = {
      ws = {
        subpath = "/leaps/ws";
      };
    };
    
See [implementation](../modules/web/services/leaps/default.nix).

# Tests

See also the unit tests at [../modules/services/reverse-proxy/test.nix](../modules/services/reverse-proxy/test.nix) which tests various scenarios and is a good example to get into the reverse proxy configuration.
