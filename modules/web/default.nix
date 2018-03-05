{ config, options, lib, ... }:

{
  imports = lib.mapAttrsToList (import ../../lib/make-webservice.nix) {
    filesender        = services/filesender;
    leaps             = services/leaps;
    mediawiki         = services/mediawiki;
    static-darkhttpd  = services/static-darkhttpd;
  };

  config = let
    mapWebServiceConfig = fun: webservices: let
      getConfig = lib.mapAttrsToList (lib.const fun);
    in lib.concatLists (lib.mapAttrsToList (lib.const getConfig) webservices);

    toplevel = import ../../lib/make-toplevel-config.nix {
      inherit config options lib;
    } (mapWebServiceConfig (cfg: cfg.toplevel)) [ "nixcloud" "webservices" ];

    # Pass a sub-option that affects the top-level nixcloud namespace to the
    # top-level with the ability to rename it. The first argument is the
    # attribute path of the top-level option whereas the second argument is the
    # option inside nixcloud.webservices that should be passed to the top-level
    # option.
    passSubOption = outer: inner: let
      inherit (config.nixcloud) webservices;
      cfgList = mapWebServiceConfig (lib.getAttrFromPath inner) webservices;
    in lib.setAttrByPath outer (lib.mkMerge cfgList);

    tests = passSubOption [ "nixcloud" "tests" "wanted" ] [ "tests" "wanted" ];

    # Special case: We don't want to pass the options to the top-level
    # unmodified because want to remove the instance.* attributes as those are
    # already merged in the config attribute of the directories submodule.
    dirs.nixcloud.directories = let
      inherit (config.nixcloud) webservices;
      modifyConfig = cfg: let
        removeInstance = lib.flip removeAttrs [ "instance" ];
      in lib.mapAttrs (lib.const removeInstance) cfg.directories;
    in lib.mkMerge (mapWebServiceConfig modifyConfig webservices);

  in lib.mkMerge [ toplevel tests dirs ];
}
