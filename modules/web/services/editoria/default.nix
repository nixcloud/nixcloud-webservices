{ config, pkgs, lib, mkUniqueUser, mkUniqueGroup, ... }:

let
  yarn2nix = import /etc/nixos/yarn2nix { inherit pkgs; };

  # FIXME rewrite this into nix to json (similar to taiga.io's config
# patch the default.js
#  sed 'db: {},', 
#         db: {
#           "user": "editoria",
#           "password": "editoria",
#           "host": "localhost",
#           "database": "editoria",
#           "port": "5432"
#         },

  local-development-config = pkgs.writeText "local-development.json" ''
    {
      "pubsweet-server": {
        "secret": "55horses4lolz",
      },
      "pubsweet-component-ink-backend":{
        "inkEndpoint":"http://inkdemo-api.coko.foundation/",
        "email":"editoria@coko.foundation",
        "password":"editoria"
      }
    }
  '';
  editoria-front-end-node_modules = (yarn2nix.mkYarnWorkspace{
    name = "editoria-front-end-node_modules";
    src = /etc/nixos/editoria;
    packageJson = ./package.json;
    yarnLock = ./yarn.lock;
    yarnNix = ./yarn.nix;
  }).Editoria ;
  editoria-front-end = pkgs.stdenv.mkDerivation {
    name = "editoria-front-end";
    src = /etc/nixos/editoria;
    installPhase = ''
      mkdir -p $out/config
      ${pkgs.rsync}/bin/rsync -avz --exclude=node_modules --exclude=config/local-development.json $src/packages/editoria-app/* $out
      rm -Rf $out/node_modules
      ln -s ${editoria-front-end-node_modules}/libexec/Editoria/node_modules $out
      chmod u+wrx $out/config
      ln -s ${local-development-config}/local-development.json $out/config
    '';
  };
in
{
  options = {
    #dbName = mkOption {
    #  default = "filesender";
    #  description = "Name of the database that holds the FileSender data.";
    #};
  };

  meta = {
    description = "A pair programming tool and library written in Golang";
    homepage = "https://github.com/jeffail/editoria/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ qknight ];
    meta.platforms = lib.platforms.linux;
  };

  config = lib.mkIf config.enable {

yarn server


    #proxyOptions.websockets = {
    #  ws = {
    #    subpath = "/editoria/ws";
    #  };
    #};

   users.editoria = {
      description = "editoria server user";
      home        = "${config.stateDir}/www";
      createHome  = true;
      group       = "editoria";
    };

    groups.editoria = {};

    database.editoria = {
      user = "editoria";
      owners = [ "editoria" ];
      type = "postgresql";
    };

    # FIXME assert that the user didn't select mysql
    database.meditoria.postCreate = let
      inherit (config.database.editoria) type;
    in ''
      yarn resetdb
      yarn start:services
    '';

    systemd.services.editoria = {
     description = "${config.uniqueName} main service (editoria)";

      wantedBy      = [ "multi-user.target" ];
      after         = [ "network.target" ];

      serviceConfig = {
        User = "editoria";
        Group = "editoria";
        Restart = "on-failure";
        WorkingDirectory = "${config.stateDir}/www";
        PrivateTmp = true;
        ExecStart = lib.concatMapStringsSep " " lib.escapeShellArg [
          "${pkgs.editoria.bin}/bin/editoria"
          "-path" config.proxyOptions.path
          "-address" "${config.proxyOptions.ip}:${toString config.proxyOptions.port}"
        ];
      };
    };


    tests.wanted = [ ./test.nix ];
  };
}
