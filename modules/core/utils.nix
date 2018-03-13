{ config, lib, ... }:

{
  # Runs the specified function on the configuration of
  # all defined web service and returns the results as a
  # list.
  #
  # Let's say the following web services are defined:
  #
  # {
  #   nixcloud.webservices.foo1.bar1.someOption = "aaa";
  #   nixcloud.webservices.foo1.bar2.someOption = "bbb";
  #   nixcloud.webservices.foo2.bar1.someOption = "ccc";
  # }
  #
  # ... and using mapWebServiceConfigToList like this:
  #
  # mapWebServiceConfigToList (x: someOption)
  #
  # Will result in the list: [ "aaa" "bbb" "ccc" ]
  _module.args.mapWebServiceConfigToList = fun: let
    inherit (config.nixcloud) webservices;
    getConfig = lib.mapAttrsToList (lib.const fun);
  in lib.concatLists (lib.mapAttrsToList (lib.const getConfig) webservices);
}
