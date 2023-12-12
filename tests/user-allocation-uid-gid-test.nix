# test for UID/GID reuse
{ pkgs, ... }: 
{
  name = "user-allocation-uid-gid-test";

  nodes = {
  
    machine1 = { pkgs, lib, ... }: {
      nixcloud.webservices.mediawiki.one = {
        enable = true;
        proxyOptions = {
          port   = 5000;
          path   = "/foo";
          domain = "example.com";
        };
      };
    };
    
    machine2 = { pkgs, lib, ... }: {
      nixcloud.webservices.mediawiki.one = {
        enable = false;
        proxyOptions = {
          port   = 5000;
          path   = "/foo";
          domain = "example.com";
        };
      };

      nixcloud.webservices.mediawiki.two = {
        enable = true;
        proxyOptions = {
          port   = 5001;
          path   = "/bar";
          domain = "example.com";
        };
      };
    };
  };

  testScript = {nodes, ...}: let
    m1 = nodes.machine1.config.system.build.toplevel;
    m2 = nodes.machine2.config.system.build.toplevel;
  in ''
    machine1.wait_for_unit("multi-user.target")
  '';
#    machine1.wait_for_open_port(5000)

#    machine1.succeed("curl localhost:5000 >&2")
#    machine1.succeed("ls -lanthr /var/lib/nixcloud/webservices/mediawiki-one >&2")
#
#    machine1.succeed("${m2}/bin/switch-to-configuration test >&2")
#    machine1.wait_for_open_port(5001)
#    machine1.succeed("curl localhost:5001 >&2")
#    machine1.succeed("cat /etc/passwd >&2")
#    machine1.succeed("ls -lanthr /var/lib/nixcloud/webservices/mediawiki-one >&2")
#    machine1.succeed("ls -lanthr /var/lib/nixcloud/webservices/mediawiki-two >&2")
#  '';

#    machine1.succeed("
#      r1=$(stat -c '%u' /var/lib/nixcloud/webservices/mediawiki-one/runtime)
#      r2=$(stat -c '%u' /var/lib/nixcloud/webservices/mediawiki-two/runtime)
#      echo $r1 >&2
#      echo $r2 >&2
#
#      if [ "$r1" == "$r2" ]; then
#        echo "Critical: UID was reused, this indicates a critical error" >&2;
#        exit 1;
#      else
#        echo "UID was not reused which is good" >&2;
#        exit 0;
#      fi;
#    ");
#  '';
}

