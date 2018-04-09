{ pkgs, ... }:

let
  inherit (pkgs) lib;

  wsModArgs = (lib.evalModules {
    modules = [
      { _module.args.wsName = "foo";
        _module.args.name = "bar";
      }
      ../modules/web/core/base.nix
    ];
  }).config._module.args;

  inherit (wsModArgs) mkUnique mkUniqueUser mkUniqueGroup;

  mkUniqueUserGroupTests = basename: fun: hashPrefix: hashedAtLen: let
    generateTestsFor = nestFun: append: isHashed: from: to: let
      mkTest = curLen: let
        genStr = len: lib.concatStrings (lib.genList (lib.const "x") len);
        testStr = genStr curLen;
      in {
        name = "${basename}${append}${toString curLen}";
        value = if isHashed then {
          expr = let
            unnested = fun testStr;
            nested = nestFun unnested;
            matchHashed = builtins.match "([^-]+)-[a-f0-9]+";
          in {
            result = matchHashed nested;
            isEqual = nested == unnested;
          };
          expected.result = [ hashPrefix ];
          expected.isEqual = true;
        } else {
          expr = nestFun (fun testStr);
          expected = "foo-bar-${genStr curLen}";
        };
      };
    in lib.listToAttrs (map mkTest (lib.range from to));

    generateTests = nestFun: append: let
      genTests = generateTestsFor nestFun;
    in genTests "Unhashed${append}" false 0 (hashedAtLen - 1)
    // genTests "Hashed${append}" true hashedAtLen 200;

    basic = generateTests lib.id "";
    nestedUniqueUser = generateTests mkUniqueUser "NestedMkUniqueUser";
    nestedUniqueGroup = generateTests mkUniqueGroup "NestedMkUniqueGroup";
    nestedUnique = generateTests mkUnique "NestedMkUnique";

  in basic // nestedUniqueUser // nestedUniqueGroup // nestedUnique;

in {
  name = "mkunique";
  type = "unit";

  tests = {
    mkUniqueWithWSname = {
      expr = mkUnique "foo";
      expected = "foo-bar";
    };

    mkUniqueWithUniqueName = {
      expr = mkUnique "foo-bar";
      expected = "foo-bar";
    };

    nestedMkUnique = {
      expr = mkUnique (mkUnique (mkUnique "xxx"));
      expected = "foo-bar-xxx";
    };
  } // mkUniqueUserGroupTests "mkUniqueUser" mkUniqueUser "user" 24
    // mkUniqueUserGroupTests "mkUniqueGroup" mkUniqueGroup "group" 24;
}
