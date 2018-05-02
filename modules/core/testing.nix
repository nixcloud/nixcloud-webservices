{ config, pkgs, lib, ... }:

let
  inherit (lib) types mkOption;
in {
  options.nixcloud.tests = {
    enable = mkOption {
      type = types.bool;
      default = true;
      example = false;
      description = ''
        Whether to run tests needed by the current system configuration.
      '';
    };

    wanted = mkOption {
      type = let
        testName = types.either types.str (types.listOf types.str);
        pathOrName = types.either types.path testName;
      in types.listOf pathOrName;
      default = [];
      apply = val: let
        unified = map (x: if lib.isString x then lib.singleton x else x) val;
      in lib.unique unified;
      example = [ "reverse-proxy" ["foo" "bar"] ];
      description = ''
        A list of tests needed for the current configuration.

        The list elements can either be plain strings or a list of strings,
        where the latter will form an attribute path.
      '';
    };
  };

  config = lib.mkIf config.nixcloud.tests.enable {
    system.extraDependencies = let
      system = if config.nixpkgs ? localSystem then config.nixpkgs.localSystem.system else config.nixpkgs.system;
      testRoot = import ../../tests { inherit pkgs system; };
      mkErr = path: let
        pathStr = lib.concatStringsSep "." path;
      in abort "Unable to find test for path ${pathStr}.";
      getTest = arg: let
        fromAttrPath = lib.attrByPath arg (mkErr arg) testRoot;
        fromPath = import ../../lib/call-test.nix { inherit pkgs system; } arg;
      in if lib.isList arg then fromAttrPath else fromPath;
    in map getTest config.nixcloud.tests.wanted;
  };
}
