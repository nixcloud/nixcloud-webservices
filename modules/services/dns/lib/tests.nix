let
  lib = import ./. {};
in (import <nixpkgs/lib>).runTests {
  testSplitDomainEmpty = {
    expr = lib.splitDomain "";
    expected = [];
  };

  testSplitDomainSimple = {
    expr = lib.splitDomain "foo.example.org";
    expected = [ "foo" "example" "org" ];
  };

  testSplitDomainMultiDots = {
    expr = lib.splitDomain "...";
    expected = [ "" "" "" "" ];
  };

  testSplitDomainWithDotLabels1 = {
    expr = lib.splitDomain "foo.exa\\.mple.org";
    expected = [ "foo" "exa\\.mple" "org" ];
  };

  testSplitDomainWithDotLabels2 = {
    expr = lib.splitDomain "\\.foo.example.org";
    expected = [ "\\.foo" "example" "org" ];
  };

  testSplitDomainDotAtEnd = {
    expr = lib.splitDomain "foo.example.org\\.";
    expected = [ "foo" "example" "org\\." ];
  };

  testSplitDomainBackslashAtEnd = {
    expr = lib.splitDomain "foo.example.org\\";
    expected = [ "foo" "example" "org\\" ];
  };

  testSplitDomainAbsolute = {
    expr = lib.splitDomain "foo.example.org.";
    expected = [ "foo" "example" "org" "" ];
  };

  testEscapeLabel = {
    expr = lib.escapeLabel "aaa\\.\n\r\t ";
    expected = "aaa\\\\\\.\\010\\013\\009\\032";
  };

  testUnescapeLabel = {
    expr = lib.unescapeLabel "aaa\\\\\\.\\010\\013\\009\\032";
    expected = "aaa\\.\n\r\t ";
  };

  testConvertEmptyDomain = {
    expr = lib.convertDomain "";
    expected = {};
  };

  testConvertRelativeDomain1 = {
    expr = lib.convertDomain "foo.example.net";
    expected.relative = [ "foo" "example" "net" ];
  };

  testConvertRelativeDomain2 = {
    expr = lib.convertDomain "foo..net";
    expected = {};
  };

  testConvertAbsoluteDomain1 = {
    expr = lib.convertDomain "foo.example.net.";
    expected.absolute = [ "foo" "example" "net" ];
  };

  testConvertAbsoluteDomain2 = {
    expr = lib.convertDomain "net.";
    expected.absolute = [ "net" ];
  };

  testConvertAbsoluteDomain3 = {
    expr = lib.convertDomain ".";
    expected.absolute = [];
  };

  testDomainTypeMerge1 = {
    expr = builtins.tryEval (lib.types.domain.merge [] [
      { value = "foo.example.org"; }
    ]);
    expected.success = true;
    expected.value.relative = [ "foo" "example" "org" ];
  };

  testDomainTypeMerge2 = {
    expr = builtins.tryEval (lib.types.domain.merge [] [
      { value = ".example.org"; }
    ]);
    expected.success = false;
    expected.value = false;
  };
}
