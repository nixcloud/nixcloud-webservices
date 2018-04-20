# nixcloud.TLS

`nixcloud.TLS` unifies TLS certificate management. 

The motivation for creating `nixcloud.TLS` was:

* It makes it easy to switch between 'ACME', 'selfsigned' or 'usersupplied' usage. This makes it easy for testing (using selfsigned TLS certificates) and in production (using "ACME" or you own certificates)
* Meaningful defaults: We encourage let's encrypt based ACME and `security.acme`
* Using the nixpkgs typing system we can merge different definitions of the service, thus making it easy to switch between different usage scenarios
* We build on top of `security.acme` but wanted to have a more modular approach to certificate management

## The identifier

We've seen the identifier in `security.acme` and at first it seemd stupid but it is actually a great concept to manage different certificates for the same domain so we copied it!

    nixcloud.TLS.certs = {
      "example.com-ACME" = {
        domain = "example.com";
        mode = "ACME";
        email = "foo@example.com";
      };
      "example.com-selfsigned" = {
        domain = "example.com";
        mode = "selfsigned";
        email = "foo@example.com";
      };
      "example.com-usersupplied" = {
        domain = "example.com";
        mode = {
          tls_certificate="/tmp/fullchain.pem";
          tls_certificate_key="/tmp/key.pem";
        };
        email = "foo@example.com";
      };
    };
    
The example above creates three certificates for the same domain. The certificates can be found in:

* /var/lib/acme/example.com-ACME/
* /var/lib/nixcloud/TLS/example.com-selfsigned/selfsigned
* /var/lib/nixcloud/TLS/example.com-usersupplied/usersupplied

But they should be referenced using:

* `config.nixcloud.TLS.certs."yourHandle".tls_certificate` 

Since the `nixcloud.TLS` abstraction will return the correct location according to the `mode` of operation.

## How to use it?

If you are using `nixcloud-webservices` or `nixcloud.email` you will be using `nixcloud.TLS` without knowing it as we use it as a default from now on.

### Using ACME certificates

    nixcloud.TLS.certs = {
      "example.com" = {
        mode = "ACME";
        email = "foo@example.com";
      };
    };

### Using 'usersupplied' certificates

    nixcloud.TLS.certs = {
      "example.com" = {
        mode = {
          tls_certificate="/tmp/fullchain.pem";
          tls_certificate_key="/tmp/key.pem";
        };
        email = "foo@example.com";
      };
    };
    
### Using 'selfsigned' certificates

    nixcloud.TLS.certs = {
      "example.com" = {
        mode = "selfsigned";
      };
    };
    
Note: `security.acme` also creates a self-signed certificate but if your testing environment can't successfully use ACME to replace it with a valid
      certificate it will always report `simp_le` errors on `nixos-rebuild switch` updates and this is the reason we created a self-signed implementation.

## Extending your service

Say you want to use `nixcloud.TLS` to manage TLS certificates for you, then this example will help you to do the setup.

You need to do three things:

1. create a nixcloud.TLS.certs."handle" record and pick your operation `mode`
2. reference the `tls_certificate` and `tls_certificate_key` from the global `config`
3. inject systemd service dependencies 

### Referencing certificate/key

If you want to reference a `tls_certificate` or a `tls_certificate_key` you can use the `nixcloud.TLS` 
handle ID (string) with the `config` variable:
    
    sslServerCert = config.nixcloud.TLS.certs."yourHandle".tls_certificate;
    sslServerKey  = config.nixcloud.TLS.certs."yourHandle".tls_certificate_key;
    
Note: Most often "yourHandle" is the domain you want to have a certificate for.

### SystemD dependencies

You also need to inject the systemd dependencies so that both `nixcloud.TLS` or `security.acme` has enough time to allocate the 
certificates before they are used from a daemon.

Here is an example how one would extend `postfix`:

    systemd.services.postfix.after = [ "nixcloud.TLS-certificates.target" ];
    systemd.services.postfix.wants = [ "nixcloud.TLS-certificates.target" ];

Note: This code was copied from `nixcloud.email`.
