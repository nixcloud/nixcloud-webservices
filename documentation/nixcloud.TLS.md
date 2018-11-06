# nixcloud.TLS

![nixcloud.TLS](logo/nixcloud.TLS.png)

`nixcloud.TLS` unifies TLS certificate management in NixOS.

The motivation for creating `nixcloud.TLS` was:

* We are lazy and don't like manual certificate management

* Easily switch between 'ACME', 'selfsigned' or 'usersupplied' scenarious:

    This makes it easy for testing (using selfsigned TLS certificates) and production (using "ACME" or you own certificates) configurations

* Because of the [ACME rate limits](https://letsencrypt.org/docs/rate-limits/) we try to minimize the amount of requests using a hashing scheme

* Replacing `simp_le` https://github.com/kuba/simp_le with `lego` https://github.com/xenolf/lego

* nixcloud.TLS runs the 'lego' service(s) with limited user rights and not as 'root' for added security and certificates are in dedicated groups so services as 'murmur' can still access them without having to be started as root!

**Note:** `nixcloud.TLS` obsoletes `security.acme` but forces you to use the `nixcloud.reverse-proxy` for your webservices. If you want to use `services.nginx` on port 80 a lot of assumptions won't work and this breaks our assumptions. See [issue 23](https://github.com/nixcloud/nixcloud-webservices/issues/23) on that matter. The good news is, you can most likely use `nixcloud.webservices.nginx` or `nixcloud.webservices.apache` instead but, again, keep in mind that your webservice must be configured to run behind a reverse-proxy.

## How to use nixcloud.TLS

The simplest configuration would be this:

    nixcloud.TLS.certs = {
      "nixcloud.io" = {};
    };

Here the identifier is the left hand string, "nixcloud.io" and the attribute set on the right is basically empty. As a result the configuration will be using default values where `domain` will be set to the identifier and `mode` will be "ACME".

A more complex example configuration for `nixcloud.TLS` would be:

    nixcloud.TLS = { 
      # this global email will be used if not overriden by certs record
      email = "global@example.com";
      certs = {
        "example.com-ACME" = {
          domain = "example.com";
          mode = "ACME";
          reload = [ "postfix.service" "myservice.service" ];
        };
        "example.com-selfsigned" = {
          domain = "example.com";
          mode = "selfsigned";
          email = "foo@example.com";
        };
        "example.com-usersupplied" = {
          domain = "example.com";
          mode = {
            tls_certificate="/root/.tls/fullchain.pem";
            tls_certificate_key="/root/.tls/key.pem";
          };
          email = "foo@example.com";
        };
      };
    };

As said, the default value for `domain` is the `identifier`. It would not make sense in any of the above examples as "example.com-ACME" is not a correct domain therefore the `domain` is set explicitly to "example.com" in each example. In `nixcloud.TLS.certs."nixcloud.io" the domain is set to "nixcloud.io" which is a correct domain and an intended default. The

The reload line in "example.com-ACME" adds two services, "postfix.service" and "myservice.service" to be reloaded once a new certificate arrives. If you would use `nixcloud.email` and `nixcloud-webservices` it would contain [ "postfix.service" "dovecot2.service" "nixcloud.reverse-proxy" "myservice.service" ] as it accumulates all defined services and applies `lib.unique` to the list.

The example above creates three certificates for the same domain. The certificates can be found in:

* `/var/lib/nixcloud/TLS/example.com-ACME/acmeSupplied/fee339b10e3d326ebb11ae590bd2b3c00077a086d18191fe11f7ac307be2a033/certificates/`
* `/var/lib/nixcloud/TLS/example.com-selfsigned/selfsigned/`
* `/var/lib/nixcloud/TLS/example.com-usersupplied/usersupplied/`

But they should be referenced using the read only mkOption(s):

* `config.nixcloud.TLS.certs."identifier".tls_certificate`
* `config.nixcloud.TLS.certs."identifier".tls_certificate_key`

Since the `nixcloud.TLS` abstraction will return the correct location according to the `mode` of operation. Yes, this is indeed amazing!

## Different usage modes in detail

If you are using `nixcloud-webservices` or `nixcloud.email` you will be using `nixcloud.TLS` without knowing it as we use it as a default from now on.

### Using ACME certificates

    nixcloud.TLS.certs = {
      "example.com" = {
        mode = "ACME";
        email = "foo@example.com";
      };
    };

**Note:** If you don't specify an email address, the abstraction will use "info@" on your domain, so here it would be "info@example.com" then. This is then used for self-signed certificates and for ACME registration.

### Using 'usersupplied' certificates

    nixcloud.TLS.certs = {
      "example.com" = {
        mode = {
          tls_certificate="/root/.tls/fullchain.pem";
          tls_certificate_key="/root/.tls/key.pem";
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

## Using nixcloud.TLS with any NixOS service

This section is for users who have a service as murmur (mumble backend) which is in nixpkgs and won't be tunneled trough `nixcloud.reverse-proxy`. Generally a servic e like https://nixos.org/nixos/options.html#ssl+cert, so basically a custom TLS configuration. 

This brief guide shows how to manage your certificates using `nixcloud.TLS` in that case.

In a nutshell, you need to do three things:

1. Create a nixcloud.TLS.certs."identifier" record and pick your `mode` of operation
2. In the service, reference the `tls_certificate` and `tls_certificate_key` from the global `config`
3. Inject systemd service dependencies 

### nixcloud.TLS configuration

    nixcloud.TLS.certs = {
      "example.org" = {
        mode = "ACME";
        users = [ "murmur" ];
        reload  = [ "murmur" ];
      };
    };

**Note:** It is important to list all the users, like murmur, so NixOS services which are not started as root still can access the certificates in nixcloud.TLS! A list of such user names can be found in https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/misc/ids.nix!

**Note:** It is important that you list your systemd services in `reload` or `restart` so they get reloaded or restarted once a new certificate arrives. Most often 'reload' is sufficient.

### Referencing certificate/key

If you want to reference a `tls_certificate` or a `tls_certificate_key` you can use the `nixcloud.TLS` 
identifier (string) with the `config` variable:

    sslServerCert = config.nixcloud.TLS.certs."example.org".tls_certificate;
    sslServerKey  = config.nixcloud.TLS.certs."example.org".tls_certificate_key;

**Note:** Most often the identifier "example.org" is the same as the the domain you want to have a certificate for. However, using such identifier you can easily issue several different certificates for the same domain. You must use the quotes, so that "example.org" is a single attribute in the Nix attribute path!

### Systemd dependencies injection

You also need to inject the systemd dependencies so that both `nixcloud.TLS` or `security.acme` has enough time to allocate the 
certificates before they are used from a daemon.

Here is an example how one would extend `postfix`:

    systemd.services.postfix.after = [ "nixcloud.TLS-certificates.target" ];
    systemd.services.postfix.wants = [ "nixcloud.TLS-certificates.target" ];

**Note:** This code was copied from `nixcloud.email`.

The "nixcloud.TLS-certificates.target" waits for these 4 targets to finish:

* nixcloud.TLS:

    * `nixcloud.TLS-selfsigned.target`
    * `nixcloud.TLS-usersupplied.target`
    * `nixcloud.TLS-acmeSuppliedPreliminary-certificates.target`
    * `nixcloud.TLS-acmeSupplied-certificates.target`

**Note:** With the "nixcloud.TLS-certificates.target" we make sure that either valid ACME generated certificates or preliminary self-signed 'fake' certificates are in place and your services will start at all.

## Debugging

Show the contents of a certificate: 

    openssl x509 -text -noout -in /var/lib/nixcloud/TLS/mail.nix.lt/acmeSupplied/5b84c8ac4508564bb7b33337fb6cf88622a8c72e56c540558413a9637e6fab7c/certificates/mail.nix.lt.crt

### Systemd jobs

These commands might come in handy:

    systemctl list-units --type=target
    systemctl list-timers --all
    systemctl status nixcloud.TLS-certificates.target
    systemctl status nixcloud.TLS-usersupplied-certificates.target
    systemctl status nixcloud.TLS-selfsigned-certificates.target
    systemctl status nixcloud.TLS

# Developing/Testing

When you change the `nixcloud.TLS` abstraction you can run tests manually by:

    cd tests
    nix-build -A TLS

Keep in mind, when you run `nixos-rebuild switch` this test is also executed implicitly.

# Thanks

Thanks to:

* http://github.com/eliasp
* https://github.com/uwap
* http://github.com/aszlig
* http://github.com/nixcloud

Special thanks for inspiration:

* `security.acme` authors, see https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/security/acme.nix 

