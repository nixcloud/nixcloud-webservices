{ system, pkgs, ... }@args: test:

let
  testLib = import <nixpkgs/nixos/lib/testing.nix> { inherit system; };

  reduceTestFun = tf: tf (args // {
    pkgs = pkgs // {
      inherit (import ../pkgs { inherit pkgs; }) nixcloud;
    };
  });

  unpackTestFun = tf:
    if builtins.isFunction tf then reduceTestFun tf
    else if builtins.isAttrs tf then tf
    else unpackTestFun (import tf);

  testArgs = unpackTestFun test;

  nodes = testArgs.nodes or (if testArgs ? machine then {
    inherit (testArgs) machine;
  } else {});

  injectCommon = name: conf: {
    imports = [ ../modules conf ];
    services.mingetty.autologinUser = "root";
    nixcloud.tests.enabled = false;
  };

  testArgsWithCommon = removeAttrs testArgs [ "machine" ] // {
    nodes = pkgs.lib.mapAttrs injectCommon nodes;
  };

in testLib.makeTest testArgsWithCommon
