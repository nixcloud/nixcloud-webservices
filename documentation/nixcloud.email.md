# nixcloud.email

`nixcloud.email` is a part of [nixcloud-webservices](https://github.com/nixcloud/nixcloud-webservices) and focuses on the deployment of a mailserver stack.

See also [../README.md](../README.md).

# Documentation

By using `nixcloud.email` you can easily maintain a mailserver with these features:

* virtualMail user abstraction
* easy way to assign passwords for mail users declaratively
* optional greylisting
* optional spamassassin
* explicit ipv4/ipv6 support
* automated ACME (for example: mail.lastlog.de)
* helpful defaults to communicate with gmail and others
* sieve filters per virtualMail user
* catchall

## Basic example

    let
      ipAddress = "8.19.10.3";
      ipv6Address = "201:48:11:403::1:1";
    in {
      nixcloud.email= {
        enable = true;
        domains = [ "lastlog.de" "dune2.de" ];
        ipAddress = ipAddress;
        ip6Address = ipv6Address;
        hostname = "mail.lastlog.de";
        users = [
          # see https://wiki.dovecot.org/Authentication/PasswordSchemes
          { name = "js"; domain = "lastlog.de"; password = "{SHA256-CRYPT}$<<<removed by qknight>>>"; }
          { name = "foo1"; domain = "dune2.de"; password = "{PLAIN}asdfasdfasdfasdf"; }
        ];
      };

# Limitations

* The mailserver setup requires a IPv4 and IPv6 address and the mailserver should be running on a machine exclusively working as a email server or some manual work is required. This is because we
bind port 80 to acquire an SSL certificate using Let's Encrypt. What you put into `hostname` is the domain of the mailserver.

* No support for shell users, only virtualUsers. This is by intention to reduce complexity in the backend.

* No support for storing virtualUsers in a database or anything dynamically updatable.

# Creating virtual users

Virtual users are given via the `nixcloud.email.users` option. You can provide a list of attributesets describing a user.

    nixcloud.email.users = [
      { name = "myuser"; domain = "mydomain.tld"; password = "{PLAIN}hello"; }
    ];

This creates a user `myuser@mydomain.tld` with the password `hello`. You should use encrypted passwords.

Passwords are generated using `doveadm`, details are listed at [PasswordSchemes](https://wiki.dovecot.org/Authentication/PasswordSchemes).

    doveadm pw -s SHA512-CRYPT

You should create a user that has an alias for postmaster to follow [RFC822](https://www.ietf.org/rfc/rfc822.txt).

## Using catchall

You can set the `catchallFor` option for a user. Provided a list of domains this user will catch all incoming mails on this domain that are not catched by an alias or a user.

    { name = "joshi"; domain = "example.com"; password = "{PLAIN}linuxFTW"; catchallFor = [ "example.com" ]; }

In this example the user joshi will also get mails addressed to anything@example.com.

You should only use each domain for which you want to set up a catchall *once*.

## Quota

You can set a per user quota by using the `quota` option.

    { name = "eris"; domain = "antifa.gmbh"; password = "{PLAIN}discordia"; quota = "10G"; }

This gives eris a quota of 10 Gigabytes. If you just enter a number without a suffix this is the number of bytes.
The following suffixes can be used:

* `b` for bytes
* `k` for kilobytes
* `M` for megabytes
* `G` for gigabytes
* `T` for terrabytes
* `%`

# Spamassassin

Spamassassin is a spam filter that uses rules and machine learning to detect spam. It can be configured with the `services.spamassassin` config.

Spamassassin will be enabled and configured automatically. If you don't want spamassassin you can use the `nixcloud.email.enableSpamassassin` option.

    nixcloud.email.enableSpamassassin = false;

# Greylisting

Greylisting prevents spam by first declining your mails requiring other mail servers to resend their emails after about 10 minutes. Most spammers don't do this and therefor greylisting helps protect you against spam.

Greylisting will be enabled automatically. If you don't want greylisting you can use the `nixcloud.email.enableGreylisting` option.

    nixcloud.email.enableGreylisting = false;

# ACME Let's Encrypt

Nixcloud Email automatically acquires a let's encrypt ssl certificate for your mail server.  This requires us to start a webserver on port 80.
If you want a web application on the same host you should disable ACME and manually provide an SSL certificate to the mail server.

## Providing your own SSL certificate

Use

    nixcloud.email.enableACME = false;

to disable ACME. To provide your own certificate you should set the following options:

    services.postfix = {
      sslCert = "/path/to/your/certificate.pem";
      sslKey = "/path/to/your/key.pem";
    };
    services.dovecot2 = {
      sslServerCert = "/path/to/your/certificate.pem";
      sslServerKey = "/path/to/your/key.pem";
    };

# Relay setup

Nixcloud email provides simple options to configure your mailserver as a relay client.
Usually you don't need to configure this.

If the other mailserver is a mailserver with the default nixcloud email setup you
only need to provide `nixcloud.email.relay.host` and `nixcloud.email.relay.passwords`.

    nixcloud.email.relay = {
      host = "mail.myrelayhost.tld";
      port = 587;
      passwords = {
        "relayUser" = "this1sApla!ntextP4ssw0rd";
      };
    };

The Port 587 is the default port and can therefor be omitted. We strongly suggest
to use the submission port (587) to deliver your emails. The `nixcloud.email.relay.host`
is the host of your relay server.

If you use an open relay you can omit the `nixcloud.email.relay.passwords` option
but we highly suggest you to not use open relays. If your counterpart is a
`nixcloud.email` setup or any other sane mailserver setup that does not use
open relays you need to provide a set of passwords.

Usually one password will be sufficient but you can provide more than one.
In the `nixcloud.email.relay.passwords.<name>` option the name is the user name
and the provided value is the plaintext password.

# Links

* [https://github.com/NixOS/nixpkgs/pull/29366](https://github.com/NixOS/nixpkgs/pull/29366)
* [https://github.com/r-raymond/nixos-mailserver/issues/13](https://github.com/r-raymond/nixos-mailserver/issues/13)
* [https://github.com/NixOS/nixpkgs/pull/29365](https://github.com/NixOS/nixpkgs/pull/29365)
