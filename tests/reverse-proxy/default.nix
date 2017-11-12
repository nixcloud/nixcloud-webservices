{  config, pkgs, lib, ... }:
with lib;

{
  # import config files (nixcloud.io specific for reverse proxy configuration)  
  # use the nix module system to have type validation and inherit meaningful 
  # default values for options which are not set explicitly
  config = {
  };

  imports =
  let
    cDir = builtins.toPath (./config);

    filesToLoad = attrNames (filterAttrs (k: v: v == "regular") (builtins.readDir cDir));
    configsFromPath = map (el: (cDir + ("/" + el) )) filesToLoad;
    toModule = x: ({ config, pkgs, lib, ... }: {
      options = {};
      config.nixcloud.reverse-proxy.extraMappings = x;
    });
  in
    fold (el: c: c ++ [(toModule (import el))]) [  ] configsFromPath;
}
