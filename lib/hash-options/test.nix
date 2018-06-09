{ pkgs ? import <nixpkgs> {}, lib ? pkgs.lib }:

let
  inherit (lib) types mkOption;

  defaultOption = mkOption {
    type = types.str;
  };

  hashOptions = import ./. { inherit lib; };

  makeTestCase = { descWhen, before, after, succeeds ? false }: let
    desc = if succeeds then "Hash is still the same but ${descWhen}"
           else "Hash is different when ${descWhen}";
    beforeHash = hashOptions before;
    afterHash = hashOptions after;
    success = if succeeds then beforeHash == afterHash
              else beforeHash != afterHash;
    operator = if succeeds then "!=" else "==";
    details = "${beforeHash} ${operator} ${afterHash}";
    info = "${desc}: ${if success then "OK" else "FAILED: ${details}"}";
  in builtins.trace info { inherit info success; };

  mkTests = cases: let
    results = lib.mapAttrsToList (lib.const makeTestCase) cases;
    allSucceed = lib.all (r: r.success) results;
    resultStr = lib.concatMapStringsSep "\n" (r: r.info) results;
    drvTrue = pkgs.writeText "tests-succeeded" "${resultStr}\n";
  in if allSucceed then drvTrue else throw "Tests failed.";

in mkTests {

  exampleChanged = {
    descWhen = "the example of the option has changed";

    before = mkOption {
      type = types.str;
      default = "foo";
      example = "bar";
    };

    after = mkOption {
      type = types.str;
      default = "foo";
      example = "different";
    };

    succeeds = true;
  };

  defaultChanged = {
    descWhen = "the default value of the option has changed";

    before = mkOption {
      type = types.str;
      default = "foo";
    };

    after = mkOption {
      type = types.str;
      default = "bar";
    };
  };

  strChangedToLines = {
    descWhen = "the type has changed and it's also a str-like type";

    before = mkOption {
      type = types.str;
      default = "123";
    };

    after = mkOption {
      type = types.lines;
      default = "123";
    };
  };

  nestedInNullOr = {
    descWhen = "a nested type has changed";

    before = mkOption {
      type = types.nullOr types.str;
      default = null;
    };

    after = mkOption {
      type = types.nullOr types.lines;
      default = null;
    };
  };

  renamedOption = {
    descWhen = "an option has been renamed";

    before.name1 = defaultOption;
    after.name2 = defaultOption;
  };

  relocatedOption = {
    descWhen = "an option has been relocated";

    before.originalLocation = defaultOption;
    after.new.location = defaultOption;
  };

  removeOption = {
    descWhen = "an option has been removed";

    before.someOption = defaultOption;
    after = {};
  };

  multipleUnchanged = {
    descWhen = "multiple options have changed";

    before = {
      opt1 = defaultOption;
      opt2 = defaultOption;
    };

    after = {
      opt1 = mkOption {
        type = types.attrs;
      };
      newOpt2 = defaultOption;
    };
  };

  submoduleDiffers = {
    descWhen = "a submodule's option has a different type";

    before = mkOption {
      type = types.submodule {
        options.foo = defaultOption;
      };
    };

    after = mkOption {
      type = types.submodule {
        options.foo = mkOption {
          type = types.listOf types.str;
        };
      };
    };
  };

  subsubmoduleDiffers = {
    descWhen = "a submodule's option of a submodule has a different type";

    before = mkOption {
      type = types.submodule {
        options.subsub = mkOption {
          type = types.submodule {
            options.foo = defaultOption;
          };
        };
      };
    };

    after = mkOption {
      type = types.submodule {
        options.subsub = mkOption {
          type = types.submodule {
            options.foo = mkOption {
              type = types.unspecified;
            };
          };
        };
      };
    };
  };

  coerced = {
    descWhen = "the to-be-coerced subtype has changed";

    before = mkOption {
      type = types.coercedTo types.int toString types.str;
    };

    after = mkOption {
      type = types.coercedTo (types.listOf types.int) toString types.str;
    };
  };

  coercedFinal = {
    descWhen = "the final subtype of a coercion has changed";

    before = mkOption {
      type = types.coercedTo types.int lib.id types.int;
    };

    after = mkOption {
      type = types.coercedTo types.int lib.id (types.nullOr types.int);
    };
  };

  enum = {
    descWhen = "values of an enum have changed";

    before = mkOption {
      type = types.enum [ "a" "b" "c" ];
    };

    after = mkOption {
      type = types.enum [ "a" "b" "x" ];
    };
  };

  defaultIsDerivation = {
    descWhen = "the default value is a derivation";

    before = mkOption {
      type = types.package;
      default = pkgs.writeText "foo" "foo";
    };

    after = mkOption {
      type = types.package;
      default = pkgs.writeText "bar" "bar";
    };
  };
}
