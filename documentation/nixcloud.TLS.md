# nixcloud.TLS

![nixcloud.TLS](https://github.com/nixcloud/nixcloud-webservices/blob/master/documentation/logo/nixcloud.TLS.png)

`nixcloud.TLS` unifies TLS certificate management in NixOS.

The motivation for creating `nixcloud.TLS` was:

* Easily switch between 'ACME', 'selfsigned' or 'usersupplied' scenarious:

    This makes it easy for testing (using selfsigned TLS certificates) and in production (using "ACME" or you own certificates)

* `security.acme` was a major inspiraten for this implementation but we needed a more modular approach to certificate management
* Meaningful defaults: 

    We encourage let's encrypt based ACME and `security.acme`
    
* Because of the [ACME rate limits](https://letsencrypt.org/docs/rate-limits/) we try to minimize the amount of requests

## How to use nixcloud.TLS

We've seen the identifier, i.e. "example.com-ACME" in the example below, in `security.acme` and at first it seemd stupid but it is actually a great concept to manage different certificates for the same domain so we copied it!

A simple example configuration for `nixcloud.TLS` would be:

    nixcloud.TLS.certs = {
      "example.com-ACME" = {
        domain = "example.com";
        mode = "ACME";
        email = "foo@example.com";
        reload = [ "postifx.service" "myservice.service" ];
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
      "example.org" = {};    
      };
    };
    
**Note:** The above example makes 3 separate ACME requests so watch your ACME rate limits usage!
    
**Note:** The default value for `domain` is the `identifier` which makes sense if you use `nixcloud.TLS` with default values. It would not make sense in any of the above examples as "example.com-ACME" is not a correct domain therefore the `domain` is set explicitly to "example.com" in each example. In `nixcloud.TLS.certs."example.org" the domain is set to "example.org" which is a correct domain and an intended default.
    
**Note:** The `reload` example for "example.com-ACME" adds two services, "postfix.service" and "myservice.service" to the [postrun](https://nixos.org/nixos/options.html#security.acme.certs.%3Cname%3E.postrun) hook. If you would use `nixcloud.email` and `nixcloud-webservices` it would contain [ "postfix.service" "dovecot2.service" "nixcloud.reverse-proxy" "myservice.service" ] as it accumulates all defined services and applies `lib.unique` to the list.
    
The example above creates three certificates for the same domain. The certificates can be found in:

* `/var/lib/acme/example.com-ACME/`
* `/var/lib/nixcloud/TLS/example.com-selfsigned/selfsigned`
* `/var/lib/nixcloud/TLS/example.com-usersupplied/usersupplied`

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
    
**Note:** `security.acme` also creates a self-signed certificate but if your testing environment can't successfully use ACME to replace it with a valid
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
    
**Note:** Most often "yourHandle" is the domain you want to have a certificate for.

### Systemd dependencies injection

You also need to inject the systemd dependencies so that both `nixcloud.TLS` or `security.acme` has enough time to allocate the 
certificates before they are used from a daemon.

Here is an example how one would extend `postfix`:

    systemd.services.postfix.after = [ "nixcloud.TLS-certificates.target" ];
    systemd.services.postfix.wants = [ "nixcloud.TLS-certificates.target" ];

The "nixcloud.TLS-certificates.target" waits for these targets:

* `acme-selfsigned-certificates.target` (security.acme)
* `acme-certificates.target` (security.acme)
* `nixcloud.TLS-selfsigned.target` (nixcloud.TLS)
* `nixcloud.TLS-usersupplied.target` (nixcloud.TLS)
    
**Note:** This code was copied from `nixcloud.email`.

## Debugging

These commands might come in handy:

    systemctl list-units --type=target
    systemctl status nixcloud.TLS-certificates.target
    systemctl status nixcloud.TLS-usersupplied-certificates.target
    systemctl status nixcloud.TLS-selfsigned-certificates.target
    systemctl status nixcloud.TLS
