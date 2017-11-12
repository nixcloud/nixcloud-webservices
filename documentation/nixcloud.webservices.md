# nixcloud.webservices

`nixcloud.webservices` is a part of [nixcloud-webservices](https://github.com/nixcloud/nixcloud-webservices) and focuses on automated deployment of multiple webservices on one or more machines .

See also [../README.md](../README.md).

# Abstraction

<!--![nixcloud.webservices layout](https://raw.githubusercontent.com/nixcloud/nixcloud-webservices/master/documentation/nixcloud-webservices.svg.png)-->

![nixcloud.webservices layout](nixcloud-webservices.svg.png)

# Motivation

All `services` in the namespace `nixcloud.webservices` hold the `special properties` as listed below:

 * Multiple instantiation of webservices like `mediawiki`

    A primary design goal is to easily support 'multiple instances' of the same webservice (mediawiki), yet isolated from each other. This is a cool feature but requires to 'fork' most webservices coming with `nixpkgs` for the time being.

 * Reverse-proxy setups, see [nixcloud.reverse-proxy.md](nixcloud.reverse-proxy.md)

    Each webservice runs in its own webserver on a different `port`. Using `nixcloud.reverse-proxy` all these different ports are consolidated into a reverse-proxy (single webserver) which runs on port 80/443 and interconnects the services to the outside world.

    One can now easily change the URL from `example.com/` to `example.org/foo` (and back) without having to modify the webservice itself.

        nixcloud.webservices.leaps.myservice = {
          enable = true;
          proxyOptions = {
            port   = 50000;
            path   = "/foo";
            domain = "example.com";
          };
        };
        
    The options `port`, `path` and `domain` must to be set always while options like `ip` and others are optional. The `port` has a special role as it can't be assigned
    automatically using the nix programming language yet. One possible solution we work on would be to use /etc/portmap and inside service reference a 'name' instead
    of a port number which is then translated into a number using the said /etc/portmap.

 * Each webservice can be addressed standalone, and as such can be automatically represented by e.g. a dedicated systemd job:

    Each webservice is closely associated with a systemd service, making it easy to shutdown/restart individual services. This decoupling makes it rather easy to manage single services in a multi-tenant environment without having these interfering with each other. This makes user/group isolation per webservice easy!

 * Database abstraction for user/db creation:

    * [main module](../modules/web/database/default.nix)
    * [postgresql implementation](../modules/web/database/postgresql.nix)
    * [mysql implementation](../modules/web/database/mysql.nix)

 * A common webservice interface: `apache`, `nginx` and `lighttpd`:

    The [common interface](../modules/web/core/backend.nix) features backends as [apache](../modules/web/backends/apache.nix) and [nginx](../modules/web/backends/nginx.nix) which support the same subset of `mkOptions` so the webservice developers can easily migrate services between the supported webservers. Of course there are differences such as `.htaccess` which are solely supported by `apache` and thus implementation details might be bound to a particular webserver. 

 * `nix evaluation time` configuration syntax checking: `apache`, `nginx` & `nixcloud-reverse-proxy`

    * [nginx_check_config.nix](../modules/web/backends/lib/nginx_check_config.nix)
    * [apache_check_config.nix](../modules/web/backends/lib/apache_check_config.nix)

 * There are suitable CI tests using [curl](https://curl.haxx.se/)/[selenium](https://github.com/SeleniumHQ/selenium), see [../tests/README.md](../tests/README.md)

     In a nutshell you can run a test explicitly like this:

        cd nixcloud-webservices/tests
        nix-build -A leaps

     But we made tests part of our evaluation so if you are using nixcloud.reverse-proxy it will always run the test before you can deploy a system which makes use of the reverse-proxy. 

 * Each webservice gets a unique, stateful directory called `stateDir`. 
 
    For instance two webservices `service1` and `service2` would use: `/var/lib/nixcloud/webservices/owncloud-service1` and `/var/lib/nixcloud/webservices/owncloud-service2` thus not interfere.
    The `stateDir` is independent of the `URL` and thus not influenced by `proxyOptions`.
    
    Using `nixcloud.webservices.owncloud.service1` would create `/var/lib/nixcloud/webservices/owncloud-service1` and while `owncloud` would be the service class, `service1` would be a 
    name, which has to be unique, given by the user. 

 * Startup scripts used to prepare the environment or perform updates, are executed as a normal user (not as a privileged user like root).
 
 * Nixcloud provides a common webserver logging interface.
 
# Example usage

# Using nixcloud-webservices `nixcloud.webservices`

## Option A: Importing modules in your local system

You import modules into your local system by adding the path to your `configuration.nix` to the `imports` list. Like this:

    imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      /path/to/nixcloud-webservices/modules
    ];

### nixcloud.webservices.mediawiki

Add this code to your `/etc/nixos/configuration.nix` file:

    nixcloud.reverse-proxy = {
      enable = true;
      extendEtcHosts = true;
    };

    nixcloud.webservices.mediawiki.test1 = {
      enable = true;
      siteName="nixcloud's demo wiki";

      proxyOptions = {
        port   = 40000;
        path   = "/wiki";
        domain = "example.com";
      };
    };

Warning: Using `extendEtcHosts = true;` extends `/etc/hosts` and if you use 'nixos.org' as example domain you won't be able to visit the official 'nixos.org' webpage!

### Rebuilding to use `nixcloud.webservices`

If you've used the above example as is, you can simply do:

    nixos-rebuild switch

Finally visit:

    https://example.com/wiki

or

    http://localhost:40000/wiki

### mediawiki's systemd backend

`mediawiki` is using the apache backend and can be controlled using:

      systemctl status mediawiki-test1
      journalctl -u mediawiki-test1

### Upload files / logging 

* static files:

      uploads (static files) can be found in `${stateDir}` which is `/var/lib/nixcloud/webservices/mediawiki-test1`

* logging:

        ls /var/lib/nixcloud/webservices/mediawiki-test1/log 
        access_log  error_log

* debugging

        journalctl -u mediawiki-test1

## Option B: Building a (KVM) VM

If you don't want to clutter your local system you can use a VM:

    nix-build '<nixpkgs/nixos>' --arg configuration '{ imports = [ ./modules ./config.nix ]; services.mingetty.autologinUser = "root"; }' -A vm

# Generating options

    git clone nixpkgs
    cd nixpkgs

    diff --git a/nixos/modules/module-list.nix b/nixos/modules/module-list.nix
    index c89bbcc71a..4aae6d61a0 100644
    --- a/nixos/modules/module-list.nix
    +++ b/nixos/modules/module-list.nix
    @@ -1,4 +1,5 @@
    [
    + /path/to/nixcloud-webservices/modules
    ./config/debug-info.nix
    ./config/fonts/corefonts.nix
    ./config/fonts/fontconfig-ultimate.nix

    nix-build --no-out-link nixos/release.nix -I nixpkgs=. -A options

Afterwards you can put it into the options search but that is mainly for internal use at nixcloud.io ATM.

# History

Here is a short bullet list of issues found with the httpd abstraction currently in nixpkgs.

## `httpd` limitations

Motivation for creating `nixcloud-webservices` are `httpd abstraction` problems:

- `nixos-rebuild switch` or `systemctl restart httpd` kills basically all VHOSTs
- Errors in `startup_script.sh` makes the service unsuable
- Supporting old php stacks forces the whole apache to be insecure
- Shared user/group with all webservices
- Only one httpd instance possible without containers
- Service options are not in the options search, if they were, they would mix with the options from http
- Mediawiki (basically all these abstractions) still focus on 'one mediawiki' and leave it to the user to make several mediawiki instance
  work in parallel. this can be complicated to manage.
- Use one httpd for more than one service complicates the source code base, making it hard to update/modify -> !KISS
- Not easy to get logging per instance which is sometimes nice to have just one place to look into
- Does not implement a `common interface`. porting webservices from httpd to nginx was complicated before this framework
- No syntax check of the apache.conf before it applies updates
- You can use your own nixpkgs revision per LXC


