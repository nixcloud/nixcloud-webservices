{ lib ? import <nixpkgs/lib> }:

let
  # Basic regexes for IPv4 and IPv6 addresses.
  v4DigitRe = "(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])";
  v6DigitRe = "([0-9a-fA-F]{0,4})";
  v4Re = "${v4DigitRe}\\.${v4DigitRe}\\.${v4DigitRe}\\.${v4DigitRe}";

  # A lot more complicated than IPv4, because IPv6 addresses have a short form
  # where you can omit digits.
  checkIPv6 = addr: let
    # First of all, replace any occurences of :: with something that we can
    # properly split on (in this case :P:, because P is not valid inside an
    # IPv6 address) and split the address.
    addrWithPs = lib.replaceStrings ["::"] [":P:"] addr;
    isNonEmptyString = val: lib.isString val && val != "";
    splittedAddr = lib.filter isNonEmptyString (builtins.split ":" addrWithPs);

    # The splitted address with converted IPv4 mapped address part.
    mappedAddr = let
      v4mapped = builtins.match v4Re (lib.last splittedAddr);
      # Append the first and second IPv4 digit and the third and fourth digit
      # as lists, so for example if we have "127.0.0.1" the list that gets
      # appended will be: [ [ "127" "0" ] [ "0" "1" ] ]
      #
      # The reason for this is that IPv4 addresses are 32bit unsigned integers,
      # which are represented by two 16bit nodes in an IPv6 address.
      converted = lib.init splittedAddr ++ [
        (lib.take 2 v4mapped) (lib.drop 2 v4mapped)
      ];
    in if v4mapped != null then converted else splittedAddr;

    # If there is more than one P inside the splitted address it means that we
    # have :: occuring more than one time.
    tooManyPs = lib.length (lib.filter (x: x == "P") mappedAddr) > 1;

    # Let's make sure we don't have a P inside the address, as it is invalid
    # anyway. Furthermore, if we have more than two : characters in sequence
    # the address is invalid as well.
    hasPInAddr = builtins.match ".*(P|:::).*" addr != null;

    # Here we're expanding the splitted address again, so if we got a list like
    # [ "1" "P" "2" ] the result is [ "1" "0" "0" "0" "0" "0" "0" "2" ].
    padAddress = acc: digit: let
      stepsAhead = lib.length mappedAddr - stepsDone;
      stepsDone = lib.length acc;
      # Add +1 because stepsDone doesn't include the current step.
      padLen = 8 - stepsDone - stepsAhead + 1;
      pad = lib.genList (lib.const "0") padLen;
      invalid = padLen < 1 && stepsAhead > 2 && stepsDone > 1;
      result = if digit == "P" then acc ++ pad else acc ++ lib.singleton digit;
    in if acc == null || invalid then null else result;

    paddedAddr = lib.foldl' padAddress [] mappedAddr;
    hasInvalidLen = paddedAddr == null || lib.length paddedAddr != 8;
    isInvalid = addr == "" || lib.length mappedAddr > 8 || tooManyPs
             || hasPInAddr || hasInvalidLen;
    checkDigit = d: lib.isList d || builtins.match v6DigitRe d != null;
  in !isInvalid && lib.all checkDigit paddedAddr;

in rec {
  # Split a domain into its nodes by taking care of escaped dots.
  splitDomain = domain: let
    chars = lib.stringToCharacters domain;
    iter = acc: char: let
      needsSplit = acc.last != "\\" && char == ".";
    in {
      last = char;
      current = if needsSplit then "" else acc.current + char;
      result = acc.result ++ lib.optional needsSplit acc.current;
    };
    splitted = lib.foldl iter { last = ""; current = ""; result = []; } chars;
    final = splitted.result ++ lib.singleton splitted.current;
  in if domain == "" then [] else final;

  # Get the relative part of "domain" respective to "root", so for example if
  # "root" is [ "foo" "bar" ] and "domain" is [ "foo" "bar" "xyz" ] the result
  # would be [ "xyz" ].
  getRelativeDomain = root: domain: let
    rootDesc = lib.concatStringsSep "." root;
    domainDesc = lib.concatStringsSep "." domain;
    noSubset = "The domain '${domainDesc}' is not a subset of '${rootDesc}'.";
    divide = rootPart: acc: let
      current = lib.last acc;
      rest = lib.init acc;
      result = if rootPart == current then rest else throw noSubset;
    in if acc == [] then [] else result;
  in lib.foldr divide domain root;

  # Escaping and unescaping for single labels.
  escapeLabel = import ./escape-label builtins.replaceStrings;
  unescapeLabel = import ./escape-label (lib.flip builtins.replaceStrings);

  # Transform a domain given as a string into either { absolute = D; } or
  # { relative = D; }, where D is the string splitted by dots.
  convertDomain = domain: let
    splitted = splitDomain domain;
    isAbsolute = lib.last splitted == "";
    # Length already checked below, so this should be non-empty.
    fqdn = if isAbsolute then lib.init splitted else splitted;
    checkLabelLen = l: lib.stringLength l <= 63 && lib.stringLength l > 0;
    resultAttr = if isAbsolute then "absolute" else "relative";
    valid = lib.isString domain && lib.length splitted > 0
         && lib.all checkLabelLen fqdn
         && lib.length fqdn <= 127;
  in if domain == "." then { absolute = []; } else lib.optionalAttrs valid {
    ${resultAttr} = fqdn;
  };

  types = {
    domain = lib.mkOptionType {
      name = "domain";
      description = "absolute or relative domain name";
      check = s: convertDomain s != {};
      merge = loc: defs: let
        value = lib.mergeOneOption loc defs;
        converted = convertDomain value;
        err = "Invalid domain '${value}' specified in "
            + "'${lib.showOption loc}'.";
      in if converted == {} then throw err else converted;
    };

    ipv4Address = lib.mkOptionType {
      name = "ipv4Address";
      description = "IPv4 address";
      check = addr: lib.isString addr && builtins.match v4Re addr != null;
      merge = lib.mergeOneOption;
    };

    ipv6Address = lib.mkOptionType {
      name = "ipv6Address";
      description = "IPv6 address";
      check = addr: lib.isString addr && checkIPv6 addr;
      merge = lib.mergeOneOption;
    };

    # This coerces a single type to a singleton list, so that we can either
    # write T or [ T ] and they both boil down to a list of Ts.
    oneOrMore = t: lib.types.coercedTo t lib.singleton (lib.types.listOf t);

    # This is used for generation of zone information for different DNS server
    # types and represents a RDATA value as a list.
    #
    # So the values are either plain strings or an attribute set with only one
    # key, those being:
    #
    #  relative: A relative domain
    #  absolute: An absolute domain
    #  autoSerial: Signal that the serial value should be automatically
    #              determined by either the name server or by the zone
    #              generator.
    #
    recordData = let
      rdataCheck = attrs: let
        names = lib.attrNames attrs;
        isDomain = names == [ "absolute" ] || names == [ "relative" ];
        isSerial = names == [ "autoSerial" ] && attrs.autoSerial == true;
      in isSerial || isDomain;
      rdataType = lib.types.addCheck lib.types.attrs rdataCheck;
    in lib.types.listOf (lib.types.either rdataType lib.types.str);
  };
}
