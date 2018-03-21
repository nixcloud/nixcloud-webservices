{ name, domain, lib, options, ... }:

let
  inherit (lib) mkOption types;
  dnsLib = import ./lib { inherit lib; };
  inherit (import ./base-record.nix { inherit lib; }) mkRecord mkRecordModule;

  domainName = lib.concatStringsSep "." domain;

  recordTypeOptions = {
    SOA = mkRecordModule ./records/soa.nix {
      recordType = "SOA";
      singleton = true;
      example = {
        mname = "ns1.example.com";
        rname = "admin.example.com";
        serial = "2018032001";
        refresh = 86400;
        retry = 7200;
        expire = 604800;
        minimum = 300;
      };
      description = ''
        The Start of Authority resource record, which designates that the name
        server is authoriative for this zone. This also marks whether a
        particular domain is a zone or just a resource record within a zone.
      '';
    };

    NS = mkRecord {
      type = dnsLib.types.oneOrMore dnsLib.types.domain;
      recordType = "NS";
      example = [ "ns1.example.com" "ns2.example.com" ];
      description = ''
        List of authoriative name servers for this domain.

        If the value is a list, more than one name servers can be specified and
        the record is resolved in a round-robin way.
      '';
    };

    CNAME = mkRecord {
      type = dnsLib.types.domain;
      recordType = "CNAME";
      example = "foo";
      description = "An alias of this domain.";
    };

    CAA = mkRecordModule ./records/caa.nix {
      recordType = "CAA";
      example.issue = "ca.example.org";
      description = ''
        Certification Authority Authorization, which indicates to certificate
        authorities whether they are authorized to issue certificates for this
        domain name.
      '';
    };

    SSHFP = mkRecordModule ./records/sshfp.nix {
      recordType = "SSHFP";
      example = {
        algorithm = "ed25519";
        hashType = "sha256";
        fingerprint = "8Ohy8G7tDQmm4AponxBklkT+BCBnDFkBNFySkxuKz0w";
      };
      description = ''
        A Secure Shell fingerprint record which identifies SSH keys that are
        associated with the current host name.
      '';
    };

    A = mkRecord {
      type = dnsLib.types.oneOrMore dnsLib.types.ipv4Address;
      recordType = "A";
      example = [ "1.2.3.4" "5.6.7.8" ];
      description = ''
        Maps a domain name to an IPv4 address.

        If the value is a list, more than one IPv4 address can be specified and
        the record is resolved in a round-robin way.
      '';
    };

    AAAA = mkRecord {
      type = dnsLib.types.oneOrMore dnsLib.types.ipv6Address;
      recordType = "AAAA";
      example = [ "dead::1" "dead::2" ];
      description = ''
        Maps a domain name to an IPv6 address.

        If the value is a list, more than one IPv6 address can be specified and
        the record is resolved in a round-robin way.
      '';
    };

    MX = mkRecordModule ./records/mx.nix {
      recordType = "MX";
      example = {
        preference = 10;
        exchange = "mail";
      };
      description = ''
        Specifies a mail server responsible for accepting email messages on
        behalf of a recipient's domain.
      '';
    };

    SRV = mkRecordModule ./records/srv.nix {
      recordType = "SRV";
      example = {
        priority = 10;
        weight = 0;
        port = 5222;
        target = "xmpp";
      };
      description = ''
        Specifies the location of services for a specific protocol and domain.
      '';
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
