# nixcloud.reverse-proxy

`nixcloud.reverse-proxy` is a part of [nixcloud-webservices](https://github.com/nixcloud/nixcloud-webservices) and focuses on the reverse proxy implementation.

The `nixcloud.reverse-proxy` acts as a gateway to have mutliple webservices in one machine.

See also [../README.md](../README.md).

# Using

When using `nixcloud.reverse-proxy.enable=true;` and then use a service from `nixcloud.webservices` you will automatically get a reverse-proxy mapping.

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

## `nixcloud.reverse-proxy.extraMappings`

Motivations to use `nixcloud.reverse-proxy.extraMappings:

* Mix your webservice, which was not built using `nixcloud.webservices` with services from `nixcloud.webservices`.
* Outsource TLS certificate management for your own webservice.
* Use `nixcloud.reverse-proxy` defaults as:

    * compression
    * TLS configuration (permitted, prohibited protocol families and so on)

* Compose 'a complex webservice' from several different webservices like: nixdoc.io/leaps, nixdoc.io/mediawiki
* Manage URL redirects for domains/resources

### Example 1: Proxying a legacy webservice (not using `nixcloud.webservices`)

The code below has a few properties:

* redirect all http requests to https
* the reverse-proxy only serves data after basicAuth has been used to authentificate the user
* it will server documents from `http://127.0.0.1:8081/`.

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
            '';              
          };
        }
      ];
    };
        
# Note

Most documentation should be generated from the source code of the reverse-proxy module, see: 

  * https://nixdoc.io/nixcloud-webservices 

# Tests

See also the unit tests at [../modules/services/reverse-proxy/test.nix](../modules/services/reverse-proxy/test.nix) which tests various scenarios and is a good example to get into the reverse proxy configuration.
