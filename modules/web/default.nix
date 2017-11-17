{ config, options, lib, ... }:

{
  imports = lib.mapAttrsToList (import ../../lib/make-webservice.nix) {
    filesender  =  services/filesender;
    leaps       =  services/leaps;
    mediawiki   =  services/mediawiki;
  };             

  config = let
    mapWebServiceConfig = fun: webservices: let
      getConfig = lib.mapAttrsToList (lib.const fun);
    in lib.concatLists (lib.mapAttrsToList (lib.const getConfig) webservices);

    toplevel = import ../../lib/make-toplevel-config.nix {
      inherit config options lib;
    } (mapWebServiceConfig (cfg: cfg.toplevel)) [ "nixcloud" "webservices" ];

    tests.nixcloud.tests.wanted = let
      inherit (config.nixcloud) webservices;
    in lib.mkMerge (mapWebServiceConfig (cfg: cfg.tests.wanted) webservices);

  in lib.mkMerge [ toplevel tests ];
}
