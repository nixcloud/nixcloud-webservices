{ config, pkgs, lib, ...}:

with lib;

{
  options = {
    nixcloud = {
      container = {
        enable = mkOption {
          type = types.bool;
          default = false;
          example = true;
          description = "Enable nixcloud LXC based container support";
        };
        internetInterface = mkOption {
          type = types.string;
          default = "enp0s3";
          example = "enp4s0";
          description = ''
            The network interface used by LXC to access the internet:

            * used for masquerading with the brNC-internet interface so containers can access the internet. 
            * used for IPv6 internet access (if configured in nixcloud.container.ipv6)

            See also: https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames
          '';
        };
        ipv6 = mkOption {
          description = ''
            If IPv6 support within the LXC based containers is wanted, provide all the required options.

            With these options a DHCPD6 server is dynamically/statefully serving IPV6 addresses to guests so that
            these can access the internet using a routable IPv6 address or can connected from outside.

            This provides full dynamic IPv6 support for our monitoring backend which uses `nixcloud.container`.

            NOTE: The IPv6 addresses are not permanent, persistent or static! Support for such setups will be implemented 
                  but after the initial release of `nixcloud.container`.
          '';
          example = {
            enable = true;
            ipv6InternetInterfaceAddress = "2001:0db8::1";
            ipv6Prefix = "2001:0db8::";
            ipv6PrefixLength = 32;
            ipv6NameServers = [ "2001:0db8::55" "2001:0db8::66" ];
          };
          default = {};
          type = types.submodule {
            options = {
              enable = mkOption {
                type = types.bool;
                example = true;
                default = false;
                description = "Enable/disable IPv6 support for nixcloud.container";
              };
              ipv6InternetInterfaceAddress = mkOption {
                type = types.string;
                example = "2001:db8:3c4d:15::1";
                default = "";
                description = "The IPv6 address which is assigned to the DHCPD6 interface and must be contained in the `ipv6Prefix` as DHCPD6 wouldn't work otherwise.";
              };
              ipv6Prefix = mkOption {
                type = types.string;
                default = "";
                example = "2001:db8:3c4d:15::";
                description = "See https://www.google.de/search?q=ipv6+prefix";
              };
              ipv6PrefixLength = mkOption {
                type = types.int;
                example = 48;
                default = 128;
                description = "See https://www.google.de/search?q=ipv6+prefix";
              };
              ipv6NameServers = mkOption {
                type = types.listOf (types.string);
                default = [];
                example = [ "2a01:4f8:0:1::add:1010" "2a01:4f8:0:1::add:9999" "2a01:4f8:0:1::add:9898" ];
                description = "A list of IPv6 nameservers which are used in the LXC guests to resolve DNS requets via IPv6";
              };
            };
          };
        };
      };
    };
  };

  config = mkIf config.nixcloud.container.enable {
    virtualisation.lxc.defaultConfig = ''
      lxc.id_map = u 0 100000 65536
      lxc.id_map = g 0 100000 65536
    '';

    virtualisation.lxc.enable = true;

    users.users.root.subGidRanges = [ { count = 65536; startGid = 100000; } ];
    users.users.root.subUidRanges = [ { count = 65536; startUid = 100000; } ];

    networking = {
      bridges.brNC-hostonly.interfaces = [];
      bridges.brNC-internet.interfaces = [];

      interfaces.brNC-hostonly = {
        ipv4.addresses = [ { address = "10.101.0.1"; prefixLength = 16; } ];
        useDHCP = false;
      };
      interfaces.brNC-internet = {
        ipv4.addresses = [ { address = "10.202.0.1"; prefixLength = 16; } ];
        useDHCP = false;
        ipv6.addresses = mkIf (config.nixcloud.container.ipv6.enable)
         [ { address = config.nixcloud.container.ipv6.ipv6InternetInterfaceAddress; prefixLength = 128; } ];
      };
      dhcpcd.denyInterfaces = [ "veth" ];
      localCommands = mkIf (config.nixcloud.container.ipv6.enable) ''
        ip r replace ${config.nixcloud.container.ipv6.ipv6Prefix}/${toString config.nixcloud.container.ipv6.ipv6PrefixLength} dev brNC-internet  
      '';

      firewall = {
        extraCommands = ''
          iptables -P FORWARD DROP
          iptables -A FORWARD -i brNC-internet -o ${config.nixcloud.container.internetInterface} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
          iptables -A FORWARD -o brNC-internet -i ${config.nixcloud.container.internetInterface} -m state --state ESTABLISHED,RELATED -j ACCEPT
          iptables -A FORWARD -p icmp --icmp-type any -j ACCEPT
          iptables --table nat --append POSTROUTING --out-interface ${config.nixcloud.container.internetInterface} -j MASQUERADE
          # allow dnsmasq (ipv4 NAT DNS resolver)
          iptables  -A INPUT -p udp -m udp -m multiport -i brNC-internet -j ACCEPT --dports 53
        '' + optionalString (config.nixcloud.container.ipv6.enable) ''
          # dhcpv6
          ip6tables -A INPUT -p tcp -m tcp -m multiport -i brNC-internet -j ACCEPT --dports 546,547
          ip6tables -A INPUT -p udp -m udp -m multiport -i brNC-internet -j ACCEPT --dports 546,547
        '';
      };
    };

    # Enable IPv4 forwarding, so we can do masquerading (container ipv4 traffic)
    boot.kernel.sysctl."net.ipv4.ip_forward" = true;

    # Enable IPv6 forwarding (container ipv6 traffic)
    # FIXME, not all interfaces need forwarding, probably only `internet`
    boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = config.nixcloud.container.ipv6.enable; 

    services.dnsmasq.enable = true;

    services.dhcpd4 = {
      enable = true;
      interfaces = [ "brNC-internet" ];
      extraConfig = ''
        option subnet-mask 255.255.0.0;
        option broadcast-address 10.202.255.255;
        option routers 10.202.0.1;
        option domain-name-servers 10.202.0.1;
        subnet 10.202.0.0 netmask 255.255.0.0 {
          range 10.202.0.10 10.202.200.200;
        }
      '';
    };

    services.dhcpd6 = mkIf (config.nixcloud.container.ipv6.enable) {
      enable = true;
      interfaces = [ "brNC-internet" ];
      extraConfig = ''
        allow client-updates;
        update-conflict-detection false;
        update-optimization false;
        authoritative;
        default-lease-time 86400;
        preferred-lifetime 80000;
        allow leasequery;
  
        subnet6 ${config.nixcloud.container.ipv6.ipv6Prefix}/${toString config.nixcloud.container.ipv6.ipv6PrefixLength} {
          range6 ${config.nixcloud.container.ipv6.ipv6Prefix}/${toString config.nixcloud.container.ipv6.ipv6PrefixLength};
          option dhcp6.name-servers ${lib.concatMapStringsSep ", " (x: x) config.nixcloud.container.ipv6.ipv6NameServers};
        }
      '';
    };    
  
    # https://serverfault.com/questions/905332/getting-ipv6-via-radvd-dhcpd6-in-an-lxc-guest-working
    services.radvd = mkIf (config.nixcloud.container.ipv6.enable) {
      enable = true;
      config = ''
        interface brNC-internet {
          AdvSendAdvert on;
          MinRtrAdvInterval 3;
          MaxRtrAdvInterval 10;
        };
      '';
    };

    environment.systemPackages = [ pkgs.nixcloud.container pkgs.libuuid ];
    nixcloud.tests.wanted = [ ../../pkgs/nixcloud/container/test.nix ];

    systemd.services."lxc-autostart" = {
      description = "LXC autostart and autostop daemon";

      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.lxc}/bin/lxc-autostart";
        ExecStop = "${pkgs.lxc}/bin/lxc-autostart --all --ignore-auto --shutdown --timeout 40";
        RemainAfterExit = true;
        Type="oneshot";
      };
    };
  };
}
