# nixcloud.webservices 'Hack your service' example

This usage, refered to as [Hack your service](nixcloud.webservices.md#hack-your-service), is a part of `nixcloud.webservices`. See also [../README.md](../README.md).

## Building the webpage using `styx`

This is an example how to use `nixcloud.webservices.apache` with `styx` (or virtually any other static page generator) in combination to GIT and polling:

* the webpage is built using 'styx'
* the source is managed by GIT
* cron properties are implemented with systemd's service/timer concept
* the webpage is updated every 10 minutes
* TLS is manged by `nixcloud.TLS` 

**Note:** Even though the webpage is generated statefully, the implementation is completely declarative. 

### /etc/nixos/configuration.nix

    ...
      imports =
        [ # Include the results of the hardware scan.
          ./hardware-configuration.nix
          <nixcloud-webservices>
          /etc/nixos/fractalide-website-styx.nix
        ];
    ...
      nixcloud.reverse-proxy.enable = true;

### /etc/nixos/fractalide-website-styx.nix

    { pkgs, config, lib, options, ... }:
    let
      buildAndSymlink = pkgs.writeScript "buildAndPublish-fractalide-website-styx.sh" ''
        #!${pkgs.stdenv.shell}
        source /etc/profile
        cd /var/lib/nixcloud/webservices/apache-fstyx/www
        if [ ! -f fractalide-website-styx ]; then
          ${pkgs.git}/bin/git clone https://github.com/fractalide/fractalide-website-styx
        fi
        cd fractalide-website-styx
        ${pkgs.git}/bin/git pull
        ${pkgs.nix}/bin/nix-build -o /var/lib/nixcloud/webservices/apache-fstyx/www/webpage
      '';
    in
    {
      nixcloud.webservices.apache.fstyx = {
        enable = true;
        proxyOptions = {
          domain = "fractalide.com";
          port = 8082;
        };
        webserver.apache = {
          extraConfig = ''
            DocumentRoot "/var/lib/nixcloud/webservices/apache-fstyx/www/webpage"
            <Directory "/var/lib/nixcloud/webservices/apache-fstyx/www/webpage">
              DirectoryIndex index.html
              Options FollowSymLinks
              AllowOverride none
              Require all granted
            </Directory>
          '';
        };
      };
      # systemctl list-timers --all
      systemd.timers.fstyx-timer = {
        description = "fractalide-website-styx trigger timer";
        wantedBy    = [ "timers.target" ];
        timerConfig = {
          OnUnitActiveSec = "10min";
          OnBootSec = "2min";
          Unit = "fractalide-website-styx.service";
          Persistent = "yes";
          AccuracySec = "1m";
          RandomizedDelaySec = "1min";
        };
      };
      systemd.services.fractalide-website-styx = {
        after = [ "network.target" ];
        serviceConfig = {
          User = "apache-fstyx-webserver";
          Group = "apache-fstyx-webserver";
          ExecStart = buildAndSymlink;
        };
      };
    }

**Note:** Make sure the User/Group name used with systemd is consistent with the webservice.
    
### Managing the service

Once deployed using `nixos-rebuild switch`, check if the timer lists your service for updates:

    systemctl list-timers --all
    ...
    Fri 2018-06-01 14:48:27 UTC  4min 36s left  Fri 2018-06-01 14:38:07 UTC  5min ago     fstyx-timer.timer               fractalide-website-styx.service
    ...

If you want to rebuild manually:

    systemctl start fractalide-website-styx
    
**Note:** Using systemd's service abstraction means we don't even have to maintain a lock file.

