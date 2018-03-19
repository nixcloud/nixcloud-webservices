{ name, domainName, lib, options, ... }:

let
  inherit (lib) mkOption types;

  domainType = (import ./lib { inherit lib; }).types.domain;

  # This coerces a single type to a singleton list, so that we can either write
  # T or [ T ] and they both boil down to a list of Ts.
  oneOrMore = t: types.coercedTo t lib.singleton (types.listOf t);

  recordTypeOptions = {
    SOA = {
      mname = mkOption {
        type = domainType;
        default = "ns";
        example = "ns.example.org";
        description = ''
          The domain name of the name server that was the original or primary
          source of data for this zone.
        '';
      };

      rname = mkOption {
        type = domainType;
        default = "dnsadmin";
        example = "admin.example.org";
        description = ''
          A domain name which specifies the mailbox of the person responsible
          for this zone.
        '';
      };

      serial = mkOption {
        type = types.nullOr types.int;
        default = 0;
        example = 19700101;
        description = ''
          The unsigned 32 bit version number of the original copy of the zone.
          Zone transfers preserve this value. This value wraps and will be
          compared using sequence space arithmetic.

          <note><para>The value <literal>null</literal> results in using the
          current Unix timestamp during build time, so be sure to take this
          into account, especially when multiple DNS servers are to be
          deployed.</para></note>
        '';
      };

      refresh = mkOption {
        type = types.int;
        default = 28800;
        description = ''
          A 32 bit time interval before the zone should be refreshed.
        '';
      };

      retry = mkOption {
        type = types.int;
        default = 7200;
        description = ''
          A 32 bit time interval that should elapse before a failed refresh
          should be retried.
        '';
      };

      expire = mkOption {
        type = types.int;
        default = 604800;
        description = ''
          A 32 bit time value that specifies the upper limit on the time
          interval that can elapse before the zone is no longer authoritative.
        '';
      };

      minimum = mkOption {
        type = types.int;
        default = 86400;
        description = ''
          The unsigned 32 bit minimum TTL field that should be
          exported with any RR from this zone.
        '';
      };
    };

    NS = mkOption {
      type = oneOrMore domainType;
      example = [ "ns1.example.com" "ns2.example.com" ];
      description = ''
        List of NS resource records for this zone.
      '';
    };

    CNAME = mkOption {
      type = domainType;
      example = "foo";
      description = ''
        XXX
      '';
    };

    CAA = mkOption {
      type = types.unspecified;
      example = "foo";
      description = ''
        XXX
      '';
    };

    SSHFP = mkOption {
      type = types.unspecified;
      example = "foo";
      description = ''
        XXX
      '';
    };

    A = mkOption {
      # XXX: Validate IPv4 address
      type = oneOrMore types.str;
      example = {
        www = [ "1.2.3.4" "1.2.3.5" ];
        mail = [ "5.6.7.8" ];
      };
      description = ''
        Maps a domain name to an IPv4 address.

        If the value is a list, more than one IPv4 address can be specified and
        the record is resolved in a round-robin way.
      '';
    };

    AAAA = mkOption {
      # XXX: Validate IPv6 address
      type = oneOrMore types.str;
      example = {
        www = [ "dead::1" "dead::2" ];
        mail = [ "dead::3" ];
      };
      description = ''
        Maps a domain name to an IPv6 address.

        If the value is a list, more than one IPv6 address can be specified and
        the record is resolved in a round-robin way.
      '';
    };

    MX = mkOption {
      type = types.attrsOf types.unspecified;
      example = {
        "mail1" = 10;
        "mail2" = 20;
      };
      description = "TODO";
    };

    SRV = mkOption {
      type = types.attrsOf types.unspecified;
      example = {
        "_jabber._tcp" = {
          prio = 10;
          weight = 0;
          port = 5269;
          dest = "legacy-xmpp.example.org.";
        };

        "_xmpp-client._tcp" = {
          prio = 10;
          weight = 0;
          port = 5222;
          dest = "xmpp";
        };

        "_xmpp-server._tcp" = {
          prio = 10;
          weight = 0;
          port = 5269;
          dest = "xmpp";
        };
      };
      description = "TODO";
    };
  };

  # All of the option attributes of the options declared in recordTypeOptions.
  allRecordTypes = lib.mapAttrs' (name: lib.const {
    inherit name;
    value = options.${name};
  }) recordTypeOptions;

  # An attribute set of record types to booleans which represent whether the
  # option for a particular record type is defined.
  rtypeDefMatrix = lib.mapAttrs (lib.const (o: o.isDefined)) allRecordTypes;

  # https://tools.ietf.org/html/rfc1034#section-3.6.2:
  #
  # If a CNAME RR is present at a node, no other data should be present; this
  # ensures that the data for a canonical name and its aliases cannot be
  # different. This rule also insures that a cached CNAME can be used without
  # checking with an authoritative server for other RR types.
  cnameAssertion = let
    definedOthers = removeAttrs rtypeDefMatrix [ "CNAME" ];
    definedDesc = lib.concatStringsSep ", " (lib.attrNames definedOthers);
  in {
    assertion = options.CNAME.isDefined -> definedOthers == {};
    message = "Having a CNAME record on '${domainName}' doesn't allow other "
            + "resource record types. However, the following record types are "
            + " defined: ${definedDesc}";
  };

in {
  options = recordTypeOptions;
  config.assertions = [ cnameAssertion ];
}
