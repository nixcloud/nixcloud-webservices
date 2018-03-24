{ lib, dnsLib, domain, defaultTTL, records }:

let
  mkRecord = { relativeDomain, ttl, type, class, rdata }: let
    maybeTTL = lib.optional (ttl != null) (toString ttl);
    name = dnsLib.joinDomainRelative relativeDomain;
    maybeEscapeVal = val: let
      # A lot more values are allowed here, but better be safe than sorry.
      needsEscaping = builtins.match "[a-zA-Z0-9]*" val == null;
    in if needsEscaping then "\"${lib.escape ["\"" "\\"] val}\"" else val;
    mkRdata = val:
      if lib.isString val then maybeEscapeVal val
      else if val ? autoSerial then toString builtins.currentTime
      else dnsLib.joinDomain val;
    rdataList = map mkRdata rdata;
    fields = [ name ] ++ maybeTTL ++ [ class type ] ++ rdataList;
  in lib.concatStringsSep " " fields;

in ''
  $ORIGIN ${dnsLib.joinDomainAbsolute domain}
  $TTL ${toString defaultTTL}
  ${lib.concatMapStringsSep "\n" mkRecord records}
''
