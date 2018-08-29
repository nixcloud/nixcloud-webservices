{ config, pkgs, lib, ... }:

{
  _module.args.nclib = rec {
    # Runs the specified function on the configuration of all defined web
    # service and returns the results as a list.
    #
    # Let's say the following web services are defined:
    #
    # {
    #   nixcloud.webservices.foo1.bar1.someOption = "aaa";
    #   nixcloud.webservices.foo1.bar2.someOption = "bbb";
    #   nixcloud.webservices.foo2.bar1.someOption = "ccc";
    # }
    #
    # ... and using mapWSConfigToList like this:
    #
    # mapWSConfigToList (x: someOption)
    #
    # Will result in the list: [ "aaa" "bbb" "ccc" ]
    mapWSConfigToList = mapWSConfigToListCond (x: true);

    # Same as mapWSConfigToList but allows to specify a filter function which
    # is given the actual web service config and should return true for configs
    # to include or falso for configs to discard.
    mapWSConfigToListCond = cond: fun: let
      inherit (config.nixcloud) webservices;
      applyCond = cfg: lib.optional (cond cfg) (fun cfg);
      getConfig = lib.mapAttrsToList (lib.const applyCond);
      getFlatCfg = wscfg: lib.concatLists (getConfig wscfg);
    in lib.concatLists (lib.mapAttrsToList (lib.const getFlatCfg) webservices);

    # Map UNIX Domain Sockets to Unix sockets, example usage:
    #
    # ipToUnix {
    #   program = "${pkgs.nginx}/bin/nginx";
    #   rules = [
    #     { direction = "outgoing"; socketPath = "/run/other.sock"; }
    #     { address = "127.0.0.1"; socketPath = "/run/local.sock"; }
    #     { socketActivation = true; fdName = "foo" }
    #   ];
    # }
    ipToUnix = args: (lib.evalModules {
      modules = [
        { config._module.args = { inherit pkgs; }; }
        { config = args; }
        ./ip-to-unix
      ];
    }).config.__result;
  };
}
