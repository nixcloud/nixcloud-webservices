{ lib ? import <nixpkgs/lib> }:

rec {
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

  types.domain = lib.mkOptionType {
    name = "domain";
    description = "absolute or relative domain name";
    check = s: convertDomain s != {};
    merge = loc: defs: let
      value = lib.mergeOneOption loc defs;
      converted = convertDomain value;
      err = "Invalid domain '${value}' specified in '${lib.showOption loc}'.";
    in if converted == {} then throw err else converted;
  };
}
