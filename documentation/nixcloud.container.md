# nixcloud.container

![nixcloud.email](https://github.com/nixcloud/nixcloud-webservices/blob/master/documentation/logo/nixcloud.container.png)

`nixcloud.container` is a part of [nixcloud-webservices](https://github.com/nixcloud/nixcloud-webservices) and focuses on NixOS based guests using LXC running on NixOS.

See also [../README.md](../README.md).

# 

[LXC](https://linuxcontainers.org/) abstraction: 

* ability to use a modified nixpkgs per LXC instance, handy for hacking!

* increased security by using unprivileged LXC guests

* default IPv6 configuration

* CI tests, see [../tests/README.md](../tests/README.md)
 
     In a nutshell you can run a test like this:
 
        cd nixcloud-webservices/tests
        nix-build -A container -I nixpkgs=/home/joachim/Desktop/projects/nixcloud/nixpkgs

# Important notice

We will maintain nixcloud.container starting at 18.03 and not support it on releases before that.

Old: Unprivileged LXC or LXC in general won't work with host systemd 2.33 so you need to revert the commit dfebb66f657240e5448a98d9efc90d4c66825274 it in nixpkgs until https://github.com/lxc/lxc/issues/1554 is fixed in nixcloud-webservices/nixpkgs as well.

