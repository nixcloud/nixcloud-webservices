{ config, pkgs, lib, ... }:

with lib;

{
  options = {};

  meta = {
    description = "A pair programming tool and library written in Golang";
    homepage = "https://github.com/jeffail/leaps/";
    license = "MIT";
    maintainers = with stdenv.lib.maintainers; [ qknight ];
    meta.platforms = stdenv.lib.platforms.linux;
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
