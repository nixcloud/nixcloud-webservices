{ system, pkgs, nixpkgs ? pkgs.path, ... }@args: test:

let
  testLib = let
    mainExpr = import "${toString nixpkgs}/nixos/lib/testing-python.nix";
    funArgs = builtins.functionArgs mainExpr;
    attrs = { inherit system; } // lib.optionalAttrs (funArgs ? pkgs) {
      inherit pkgs;
    };
  in mainExpr attrs;

  inherit (pkgs) lib;

  getRelativePathStr = path: let
    root = toString ./..;
  in lib.removePrefix "/" (lib.removePrefix root (toString path));

  unitTest = pkgs.stdenv.mkDerivation {
    name = "unit-test-${testArgs.name}";
    buildInputs = [ pkgs.nix pkgs.jq ];

    NIX_PATH = "nixpkgs=${nixpkgs}:root=${lib.cleanSource ./..}";

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

      in (import <nixpkgs>/lib).runTests tests
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

    passthru.test = unitTest;
  };

  vmTest = testLib.makeTest (removeAttrs testArgsWithCommon [ "type" ] // {skipLint = true;}); # FIXME remove skipLint later on

  reduceTestFun = tf: tf (args // {
    pkgs = pkgs // {
      inherit (import ../pkgs { inherit pkgs; }) nixcloud;
    };
    inherit nixpkgs;
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
    imports = [ ../modules ../tests/common/eatmydata.nix conf ];
    services.mingetty.autologinUser = "root";
    # We don't want to wait for the timeout on https://cache.nixos.org/.
    nix.binaryCaches = lib.mkOverride 90 [];
    nixcloud.tests.enable = false;
    # Do not ever send out requests to letsencrypt.org.
    nixcloud.TLS.testMode = lib.mkOverride 90 true;
  };

  testArgsWithCommon = removeAttrs testArgs [ "machine" ] // {
    nodes = lib.mapAttrs injectCommon nodes;
    # This is so that we have a custom error message once one of our VM tests
    # has failed.
    testScript = args:
    let
      inherit (testArgs) testScript;
      #mkPerlStr = val: "'${lib.escape ["\\" "'"] val}'";
      isTestScriptFun = builtins.isFunction testScript;
      realScript = if isTestScriptFun then testScript args else testScript;
#      import subprocess
#      import sys
#      import os
    in ''
      import os

      ${realScript}
      print("hello world")'';

#        except subprocess.CalledProcessError as e:
#            sys.stdout.reconfigure(encoding="utf-8")
#            error_message = str(e)
#            print(
#                "💥💥💥 \x1b[1;31m nixcloud test failed: \x1b[m${testArgs.name} 💥💥💥\n",
#                "\x1b[1;31mMessage: {error_message} 💥💥💥\n".format(error_message=error_message),
#                "In case the machine was too slow (virtualized, not enough ram, too much cpu load, etc) then you can also disable the tests by adding:\n",
#                "     nixcloud.tests.enable = false;\n",
#                "to your /etc/nixos/configuration.nix and still use nixcloud-webservices.\x1b[m",
#                file=sys.stderr,
#            )
#            sys.exit(1)
#    '';
#    in ''
#        import subprocess
#        import sys
#
#        try:
#            subprocess.run(
#                [
#                    "${pkgs.python3}/bin/python",
#                    "${realScript}",
#                ],
#                check=True,
#                text=True,
#            )
#        except subprocess.CalledProcessError as e:
#            sys.stdout.reconfigure(encoding="utf-8")
#            error_message = str(e)
#            print(
#                "💥💥💥 \x1b[1;31m nixcloud test failed: \x1b[m${testArgs.name} 💥💥💥\n",
#                "\x1b[1;31mMessage: {error_message} 💥💥💥\n".format(error_message=error_message),
#                "In case the machine was too slow (virtualized, not enough ram, too much cpu load, etc) then you can also disable the tests by adding:\n",
#                "     nixcloud.tests.enable = false;\n",
#                "to your /etc/nixos/configuration.nix and still use nixcloud-webservices.\x1b[m",
#                file=sys.stderr,
#            )
#            sys.exit(1)
#    '';
#      eval {
#        ${realScript}
#      };
#      if (my $error = $@) {
#        chomp $error;
#        print STDERR
#                "💥💥💥 \x1b[1;31m nixcloud test failed: \x1b[m${testArgs.name} 💥💥💥\n",
#                "\x1b[1;31mMessage: {error_message} 💥💥💥\n".format(error_message=error_message),
#                "In case the machine was too slow (virtualized, not enough ram, too much cpu load, etc) then you can also disable the tests by adding:\n",
#                "     nixcloud.tests.enable = false;\n",
#                "to your /etc/nixos/configuration.nix and still use nixcloud-webservices.\x1b[m",
#        exit(1);
#      }
  };

in if (testArgs.type or "vm") == "unit" then unitTest else vmTest
