{ system, pkgs, ... }@args: test:

let
  testLib = import <nixpkgs/nixos/lib/testing.nix> { inherit system; };
  inherit (pkgs) lib;

  getRelativePathStr = path: let
    root = toString ./..;
  in lib.removePrefix "/" (lib.removePrefix root (toString path));

  unitTest = pkgs.stdenv.mkDerivation {
    name = "unit-test-${testArgs.name}";
    buildInputs = [ pkgs.nix pkgs.jq ];

    NIX_PATH = "nixpkgs=${pkgs.path}:root=${lib.cleanSource ./..}";

    testExpr = let
      testPath = "<root/${getRelativePathStr test}>";
      pkgsPath = "<root/${getRelativePathStr ../pkgs}>";
    in ''
      let
        pkgs = import <nixpkgs> {};

        reduceTestFun = tf: tf {
          pkgs = pkgs // {
            inherit (import ${pkgsPath} { inherit pkgs; }) nixcloud;
          };
        };

        unpackTestFun = tf:
          if builtins.isFunction tf then reduceTestFun tf
          else if builtins.isAttrs tf then tf
          else unpackTestFun (import tf);

        tests = pkgs.lib.mapAttrs' (name: value: {
          name = "test_''${name}";
          inherit value;
        }) (unpackTestFun ${testPath}).tests;

      in (import <nixpkgs/lib>).runTests tests
    '';

    buildCommand = ''
      export TEST_ROOT="$(pwd)/test-tmp"
      export NIX_CONF_DIR="$TEST_ROOT/etc"
      export NIX_DB_DIR="$TEST_ROOT/db"
      export NIX_LOCALSTATE_DIR="$TEST_ROOT/var"
      export NIX_STATE_DIR="$TEST_ROOT/var/nix"
      export NIX_STORE_DIR="$TEST_ROOT/store"
      nix-store --init

      test_output="$(
        nix-instantiate --show-trace --eval --json --strict -E "$testExpr"
      )"

      eval "$(echo "$test_output" | jq -r '
        map(.name + ": expected '\'''" +
            (.expected | tostring) + "'\''' but got '\'''" +
            (.result | tostring) + "'\'''")
        | @sh "echo \(. | join("\n"))"
      ')"

      [ "$test_output" = '[]' ]
      touch $out
    '';
  };

  vmTest = testLib.makeTest (removeAttrs testArgsWithCommon [ "type" ]);

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

in if (testArgs.type or "vm") == "unit" then unitTest else vmTest
