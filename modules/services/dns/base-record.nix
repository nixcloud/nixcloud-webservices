{ lib ? import <nixpkgs/lib> }:

let
  inherit (lib) types;
  dnsLib = import ./lib { inherit lib; };

  mkBaseRecordOptions = recordType: {
    record.ttl = lib.mkOption {
      type = types.nullOr (types.ints.between 0 2147483647);
      default = null;
      example = 120;
      description = ''
        An integer that specifies the time interval (in seconds) that the
        resource record may be cached before it should be discarded.

        If the value is <literal>null</literal> the default TTL of the zone is
        used.
      '';
    };

    record.class = lib.mkOption {
      type = types.either types.ints.u16 (types.enum [
        # https://www.iana.org/assignments/dns-parameters/#dns-parameters-2
        "IN" "CH" "HS" "NONE" "ANY"
      ]);
      default = "IN";
      example = "CH";
      description = ''
        The class to use for this record. Can be either a string for assigned
        classes by the IANA or an integer.
      '';
    };

    record.type = lib.mkOption {
      type = types.either types.ints.u16 (types.enum [
        # https://www.iana.org/assignments/dns-parameters/#dns-parameters-4
        "A" "NS" "CNAME" "SOA" "MB" "MG" "MR" "NULL" "WKS" "PTR" "HINFO"
        "MINFO" "MX" "TXT" "RP" "AFSDB" "X25" "ISDN" "RT" "NSAP" "NSAP-PTR"
        "SIG" "KEY" "PX" "GPOS" "AAAA" "LOC" "EID" "NIMLOC" "SRV" "ATMA"
        "NAPTR" "KX" "CERT" "DNAME" "SINK" "OPT" "APL" "DS" "SSHFP" "IPSECKEY"
        "RRSIG" "NSEC" "DNSKEY" "DHCID" "NSEC3" "NSEC3PARAM" "TLSA" "SMIMEA"
        "HIP" "NINFO" "RKEY" "TALINK" "CDS" "CDNSKEY" "OPENPGPKEY" "CSYNC"
        "SPF" "UINFO" "UID" "GID" "UNSPEC" "NID" "L32" "L64" "LP" "EUI48"
        "EUI64" "TKEY" "TSIG" "URI" "CAA" "AVC" "DOA" "TA" "DLV"
      ]);
      default = recordType;
      example = "AAAA";
      description = ''
        The record type, which can either be a string or an integer if it's not
        an assigned type by the IANA.
      '';
    };

    record.rdata = lib.mkOption {
      type = dnsLib.types.recordData;
      example = [ "0" { absolute = "example.org"; } ];
      internal = true;
      description = ''
        The contents of the actual record data dependent on the type specified
        in the <option>type</option> option and the class specified in the
        <option>class</option> option.
      '';
    };
  };

in {
  mkRecord = { type, recordType, description, ... }@attrs: let
    optionAttrs = removeAttrs attrs [ "recordType" ];
    coerceToRecord = def: { value = def; };
    baseRecord = { config, ... }: {
      options = (mkBaseRecordOptions recordType) // {
        value = lib.mkOption optionAttrs;
      };
      config.record.rdata = lib.toList config.value;
    };
  in lib.mkOption (optionAttrs // {
    type = types.coercedTo type coerceToRecord (types.submodule baseRecord);
    description = ''
      ${description}

      If you want to provide more options like <option>ttl</option> or
      <option>class</option>, you can provide an attribute set of options
      instead of the plain value. The actual value in the attribute set is then
      called <option>value</option>.

      So for example if you have the value <literal>foo</literal> and want to
      set a TTL of 100 seconds, instead of just using <literal>foo</literal>
      the definition is <literal>{ value = foo; record.ttl = 100; }</literal>.
    '';
  });

  mkRecordModule = submodule: { recordType, singleton ? false, ... }@attrs: let
    optionAttrs = removeAttrs attrs [ "recordType" "singleton" ];
    type = types.submodule {
      imports = lib.singleton submodule;
      options = mkBaseRecordOptions recordType;
      config._module.args = { inherit dnsLib; };
    };
  in lib.mkOption (optionAttrs // {
    type = if singleton then type else types.either type (types.listOf type);
  } // lib.optionalAttrs (!singleton) {
    description = ''
      ${attrs.description}

      If this is a list, more than one entry can be specified for the same
      resource record.
    '';
  });
}
