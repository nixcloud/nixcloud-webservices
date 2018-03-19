let
  lib = import ./. {};
in (import <nixpkgs/lib>).runTests {
  testSplitDomainSimple = {
    expr = lib.splitDomain "foo.example.org";
    expected = [ "foo" "example" "org" ];
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
}
