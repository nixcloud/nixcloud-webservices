{ config, pkgs, lib, mkUniqueUser, mkUniqueGroup, ... }:
{
  options = {};

  meta = {
    description = "A pair programming tool and library written in Golang";
    homepage = "https://github.com/jeffail/leaps/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ qknight ];
    meta.platforms = lib.platforms.linux;
  };

  config = lib.mkIf config.enable {

    # inject the leaps websocket for cooperative document opening/editing into proxyOptions
    proxyOptions.websockets = {
      ws = {
        subpath = "/leaps/ws";
      };
    };

    directories.www.postCreate = ''
      cat > README.md <<EOF
      # No files to edit other than this one?

      You can add more files into \`${config.stateDir}/www\` to edit them
      collaberatively via your Leaps instance.
      EOF
    '';

    users.leaps = {
      description = "Leaps server user";
      home        = "${config.stateDir}/www";
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
        WorkingDirectory = "${config.stateDir}/www";
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
