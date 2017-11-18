{ config, pkgs, lib, ... }:

with lib;

/* The leaps service:
   You need to create files in /var/lib/nixcloud/webservices/leaps-z (or similar) with the
   right permissions and uid/gid ownership manually.
   
   The uid/gid can be looked up in /etc/passwd or by using ls -lathr on the stateDir.
*/

{
  options = {};

  meta = {
    description = "A pair programming tool and library written in Golang";
    homepage = "https://github.com/jeffail/leaps/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ qknight ];
    meta.platforms = lib.platforms.linux;
  };
  
  config = mkIf config.enable {

    # inject the leaps websocket for cooperative document opening/editing into proxyOptions
    proxyOptions.websockets = {
      ws = {
        subpath = "/leaps/ws";
      };
    };
    
    users.leaps = {
      description = "Leaps server user";
      home        = config.stateDir;
      createHome  = true;
      group       = "leaps";
    };

    groups.leaps = {};

    systemd.services.leaps = {
     description = "${config.uniqueName} main service (leaps)";

      wantedBy      = [ "multi-user.target" ];
      after         = [ "network.target" ];

      serviceConfig = {
        User = "leaps";
        Group = "leaps";
        Restart = "on-failure";
        WorkingDirectory = config.stateDir;
        PrivateTmp = true;
        ExecStart = lib.concatMapStringsSep " " lib.escapeShellArg [
          "${pkgs.leaps.bin}/bin/leaps"
          "-path" config.proxyOptions.path
          "-address" "${config.proxyOptions.ip}:${toString config.proxyOptions.port}"
        ];
      };
    };

    tests.wanted = [ ./test.nix ];
  };
}
