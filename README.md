# nixcloud-webservices

This [nixpkgs](https://github.com/NixOS/nixpkgs) extension, called [nixcloud-webservices](https://github.com/nixcloud/nixcloud-webservices), focuses on ease of deployment of web-related technologies. 

You should continue to read one of these documentations:

* [nixcloud.webservices](documentation/nixcloud.webservices.md)
* [nixcloud.reverse-proxy](documentation/nixcloud.reverse-proxy.md)
* [nixcloud.email](documentation/nixcloud.email.md)

It features the development stack we use at [https://nixcloud.io](https://nixcloud.io)

# Get the source

    git clone https://github.com/nixcloud/nixcloud-webservices

# Importing

## Option A: Importing modules in your local system

You import modules into your local system by adding the path to your `configuration.nix` to the `imports` list. Like this:

    imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      /path/to/nixcloud-webservices/modules
    ];
    
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
- [clever](https://github.com/cleverca22) (Helping with hydra.nixcloud.io)
- [brauner](https://github.com/brauner) (Help with LXC)
- [leenaars](https://github.com/leenaars) (Requirements, testing, review)
- [seitz](https://github.com/seitz)
- [qknight](https://github.com/qknight)

Among all who didn't make it into this list! Thanks for helping with writing this!
