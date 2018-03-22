let
  lib = import ./. {};

  ipAddrFixtures = {
    v4valid = [
      "0.0.0.0" "255.255.255.255" "1.2.3.4" "253.252.251.250" "1.2.255.254"
    ];

    v4invalid = [
      "-1.2.3.4" "10." "172.16." "198.168.0." "127.0.0.1." "0.00.0.0"
      "0.0.000000000000.0" "0.256.0.1" "1.2.3.4.5" "256.255.65535"
      "0x12.0X34.0x5678" "0x12.0X34.0x56.0X78" "255.0xFF.0177777" "4294967295"
      "255.255.255.0377" "255.16777215" "00377.0XFFFFFF" "255.255.65535"
      "4294967296" "0Xff.000000000377.0x0000ff.255" "0x100000000"
      "040000000000" "1.2.3.-4" "1.2.-3.4" "1.-2.3.4" "10.0x019876"
      "012.01.054321" "0" "00" "0.0" "00.00.00"
    ];

    v6valid = [
      "7:6:5:4:3::" "7:6:5:4::" "7:6:5:4:3:2::" "7:6:5:4:3:2:1::" "::5:4:3:2:1"
      "::6:5:4:3:2:1" "::7:6:5:4:3:2:1" "7::" "7:6::" "7:6:5::"
      "c11:0c22:5c33::0088" "c11:0c22::0088" "c11:0c22:5c33::55c0:c66c:77:0088"
      "c11:0c22:5c33:c440::c66c:77:0088" "c11:0c22:5c33::c66c:77:0088"
      "c11:0c22:5c33:c440::77:0088" "c11:0c22:5c33:c440:55c0::0088"
      "c11::55c0:c66c:77:0088" "c11:0c22:5c33:c440:55c0::77:0088"
      "c11:0c22:5c33:c440:55c0:c66c::0088" "c11:0c22:5c33:c440::0088"
      "c11::c66c:77:0088" "c11:0c22::77:0088" "c11:0c22::c66c:77:0088"
      "c11:0c22:5c33::77:0088" "c11:0c22:5c33:c440:55c0:c66c:77:0088"
      "c11::5c33:c440:55c0:c66c:77:0088" "c11:0c22::c440:55c0:c66c:77:0088"
      "c11::c440:55c0:c66c:77:0088" "c11:0c22::55c0:c66c:77:0088"
      "c11::77:0088" "f:f11::0100:2" "::17" "0700::" "::2:1" "::3:2:1"
      "::4:3:2:1" "::FFFF:1.2.255.254"
      "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff"
    ];

    v6invalid = [
      ":::" "f:::2" "::-1" "0" "00000000000037777777777" "0xffffffff" "::g"
      "0x12345678" "0x12.0x345678" "01000::" "::8:7:6:5:4:3:2:1" "::5.-4.3.2"
      "8:7:6:5:4:3:2:1::" "8:7:6:5:4::3:2:1" "::-5.4.3.2" "::5.4.-3.2"
      "::5.4.3.-2" "::FFFF:1.2.3.4.5" "::10." "::FFFF:172.16." "f:f11::10100:2"
      "f:f11::01100:2" "::17000" "::01700" "10000::" "fe80::198.168.0."
      "::1.256.3.4" "::1.2.3.4.5" "::1.2.3.04" "fec0::fFfF:127.0.0.1."
    ];
  };

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

  testValidIPv4Addresses = {
    expr = map lib.types.ipv4Address.check ipAddrFixtures.v4valid;
    expected = map (x: true) ipAddrFixtures.v4valid;
  };

  testInvalidIPv4Addresses = {
    expr = map lib.types.ipv4Address.check ipAddrFixtures.v4invalid;
    expected = map (x: false) ipAddrFixtures.v4invalid;
  };

  testValidIPv6Addresses = {
    expr = map lib.types.ipv6Address.check ipAddrFixtures.v6valid;
    expected = map (x: true) ipAddrFixtures.v6valid;
  };

  testInvalidIPv6Addresses = {
    expr = map lib.types.ipv6Address.check ipAddrFixtures.v6invalid;
    expected = map (x: false) ipAddrFixtures.v6invalid;
  };

  testGetRelativeDomainSingleNode = {
    expr = let
      root = [ "example" "org" ];
      domain = [ "foo" "example" "org" ];
    in lib.getRelativeDomain root domain;
    expected = [ "foo" ];
  };

  testGetRelativeDomainMultipleNodes = {
    expr = let
      root = [ "example" "org" ];
      domain = [ "foo" "bar" "xyz" "example" "org" ];
    in lib.getRelativeDomain root domain;
    expected = [ "foo" "bar" "xyz" ];
  };

  testGetRelativeDomainNonMatching = {
    expr = let
      root = [ "example" "org" ];
      domain = [ "foo" "example" "net" ];
    in builtins.tryEval (lib.getRelativeDomain root domain);
    expected.success = false;
    expected.value = false;
  };

  testGetRelativeDomainEmpty = {
    expr = lib.getRelativeDomain [] [];
    expected = [];
  };

  testGetRelativeDomainRootEmpty = {
    expr = lib.getRelativeDomain [] [ "a" "b" "c" ];
    expected = [ "a" "b" "c" ];
  };
}
