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
    in
    ...
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

## Limitations

* The mailserver setup requires a IPv4 and IPv6 address and the mailserver should be running on a machine exclusively working as a email server. What you put into `hostname` is the address of the mailserver you would write into your mail client. This example handles two domains but users at `dune2.de` still have to use `mail.lastlog.de` as their mailserver.

* No support for shell users, only virtualUsers. This is by intention to reduce complexity in the backend.

# Creating virtual users

Passwords are generated using `doveadm`, details are listed at [PasswordSchemes](https://wiki.dovecot.org/Authentication/PasswordSchemes).

    doveadm pw -s SHA512-CRYPT

# Using catchall

You can use this code:

    { name = "joshi"; domain = "example.com"; password = "{PLAIN}linuxFTW"; catchallFor = [ "example.com" ]; }

# Links

* [https://github.com/NixOS/nixpkgs/pull/29366](https://github.com/NixOS/nixpkgs/pull/29366)
* [https://github.com/r-raymond/nixos-mailserver/issues/13](https://github.com/r-raymond/nixos-mailserver/issues/13)
* [https://github.com/NixOS/nixpkgs/pull/29365](https://github.com/NixOS/nixpkgs/pull/29365)
