{ lib ? import <nixpkgs/lib> }:

{
  # Split a domain into its nodes by taking care of escaped dots.
  splitDomain = domain: let
    splitted = builtins.split "([^\\])\\." domain;
    fixDots = { current, result }: val:
      if lib.isList val && lib.length val == 1 then {
        current = null;
        result = result ++ lib.singleton (current + (lib.head val));
      } else {
        current = val;
        inherit result;
      };
    fixed = lib.foldl fixDots { current = null; result = []; } splitted;
  in fixed.result ++ lib.singleton fixed.current;

  # Escaping and unescaping for single labels.
  escapeLabel = import ./escape-label builtins.replaceStrings;
  unescapeLabel = import ./escape-label (lib.flip builtins.replaceStrings);
}
