{ config, options, lib, nclib, ... }:

{
  imports = lib.mapAttrsToList (import ../../lib/make-webservice.nix) {
    apache            = services/apache;
    nginx             = services/nginx;
    filesender        = services/filesender;
    hydra             = services/hydra;
    leaps             = services/leaps;
    mediawiki         = services/mediawiki;
    static-darkhttpd  = services/static-darkhttpd;
    static-nginx      = services/static-nginx;
    mattermost        = services/mattermost;
  };

  config = let
    # A list of all the "toplevel" option definitions of all web services.
    toplevel = let
      getConfig = lib.mapAttrsToList (lib.const (cfg: cfg.toplevel));
      mapTL = w: lib.concatLists (lib.mapAttrsToList (lib.const getConfig) w);
    in import ../../lib/make-toplevel-config.nix {
      inherit config options lib;
    } mapTL [ "nixcloud" "webservices" ];

    # Pass a sub-option that affects the top-level nixcloud namespace to the
    # top-level with the ability to rename it. The first argument is the
    # attribute path of the top-level option whereas the second argument is the
    # option inside nixcloud.webservices that should be passed to the top-level
    # option.
    passSubOption = outer: inner: let
      cfgList = nclib.mapWSConfigToList (lib.getAttrFromPath inner);
    in lib.setAttrByPath outer (lib.mkMerge cfgList);

    tests = passSubOption [ "nixcloud" "tests" "wanted" ] [ "tests" "wanted" ];

    # Special case: We don't want to pass the options to the top-level
    # unmodified because want to remove the instance.* attributes as those are
    # already merged in the config attribute of the directories submodule.
    dirs.nixcloud.directories = let
      modifyConfig = cfg: let
        removeInstance = lib.flip removeAttrs [ "instance" ];
      in lib.mapAttrs (lib.const removeInstance) cfg.directories;
    in lib.mkMerge (nclib.mapWSConfigToList modifyConfig);

  in lib.mkMerge [ toplevel tests dirs ];
}
