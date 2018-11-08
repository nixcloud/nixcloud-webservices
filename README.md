# nixcloud-webservices

This [nixpkgs](https://github.com/NixOS/nixpkgs) extension, called [nixcloud-webservices](https://github.com/nixcloud/nixcloud-webservices), focuses on ease of deployment of web-related technologies. 

You should continue to read one of these documentations:

* [nixcloud.webservices](documentation/nixcloud.webservices.md)
* [nixcloud.reverse-proxy](documentation/nixcloud.reverse-proxy.md)
* [nixcloud.email](documentation/nixcloud.email.md)
* [nixcloud.TLS](documentation/nixcloud.TLS.md)
* [nixcloud.container](https://github.com/nixcloud/nixcloud-container)


It features the development stack we use at [https://nixcloud.io](https://nixcloud.io). 

Continuous integration at <https://hydra.nixcloud.io/project/nixcloud-webservices>

# Using nixcloud-webservices

Depending on which NixOS version you're on you can get different channels of
nixcloud-webservices which are tested against different NixOS releases:

## For NixOS 18.03

```sh-session
# nix-channel --add https://hydra.nixcloud.io/channel/custom/nixcloud-webservices/release-18.03/nixcloud-webservices
# nix-channel --update
```

18.03 is obsolete:

* update to 18.09 by removing the 18.03 with the 18.09 channel and do a `nix-channel --update` and a `nixos-rebuild switch`
* also update the `system.stateVersion = "18.09";` when you are at it 

## For NixOS 18.09

```sh-session
# nix-channel --add https://hydra.nixcloud.io/channel/custom/nixcloud-webservices/release-18.09/nixcloud-webservices
# nix-channel --update
```

You can find nixcloud-webservices specific options in the [release-18.09 manual](https://hydra.nixcloud.io/job/nixcloud-webservices/release-18.09/manual/latest/download/1).

## For NixOS Unstable

```sh-session
# nix-channel --add https://hydra.nixcloud.io/channel/custom/nixcloud-webservices/nixos-unstable/nixcloud-webservices
# nix-channel --update
```

You can find nixcloud-webservices specific options in the [nixos-unstable manual](https://hydra.nixcloud.io/job/nixcloud-webservices/nixos-unstable/manual/latest/download/1).

## Adding nixcloud-webservices to your configuration.nix

Simply append `<nixcloud-webservices>` to your `imports` list and you're ready
to go, for example:

```nix
{
  imports = [
    ./hardware-configuration.nix
    <nixcloud-webservices>
  ];
  # ... other options ...
}
```

# Get the source

Alternatively if you want to hack on nixcloud-webservices, you can also Git
clone it with:

```sh-session
$ git clone https://github.com/nixcloud/nixcloud-webservices
```

# Importing

## Option A: Importing modules in your local system

You import modules into your local system by adding the path to your `configuration.nix` to the `imports` list. Like this:

```nix
{
  imports = [
    ./hardware-configuration.nix
    /path/to/nixcloud-webservices
  ];
  # ... other options ...
}
```

## Option B: Building a (KVM) VM

If you don't want to clutter your local system you can use a VM:

    nix-build '<nixpkgs/nixos>' --arg configuration '{ imports = [ ./modules ./config.nix ]; services.mingetty.autologinUser = "root"; }' -A vm

Note: You have to create `config.nix` manually, it contains basically the lines we put in `/etc/nixos/configuration.nix` in previous examples.

Note: This is for advanced users who know how VMs on NixOS work.
    
# License

The license can be found in [LICENSE](LICENSE).

For inquiries, please contact:

 * Joachim Schiele <js@lastlog.de>
 * Paul Seitz <paul.m.seitz@gmail.com>

# Thanks

Many thanks to:

- [https://www.internetsociety.org/](https://www.internetsociety.org/) (Sponsor)
- [ISOC.nl](https://ISOC.nl) (Sponsor)
- [Internet hardening fund](https://nlnet.nl/internethardening/) (Sponsor)
- [profpatsch](https://github.com/Profpatsch) (Early prototyping)
- [aszlig](https://github.com/aszlig) (NixOS module system)
- [uwap](https://github.com/uwap) (Email abstraction)
- [griff](https://github.com/griff) (Email abstraction)
- [elias](https://github.com/eliasp) (nixcloud.TLS, email abstraction)
- [clever](https://github.com/cleverca22) (Helping with hydra.nixcloud.io)
- [brauner](https://github.com/brauner) (Help with LXC)
- [leenaars](https://github.com/leenaars) (Requirements, testing, review)
- [seitz](https://github.com/seitz)
- [qknight](https://github.com/qknight)

Among all who didn't make it into this list! Thanks for helping with writing this!
