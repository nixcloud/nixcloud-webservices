{ lib, options, ... }:

let
  inherit (lib) types;

  # This one is special, because we need to use this for generation of the
  # documentation on the zones option.
  recordsType = types.submodule {
    imports = [ ./records.nix ];
    options = { inherit (options) assertions; };
    config._module.args.domainName = "xxx"; # TODO!
  };

  # The maximum domain name length is 255 and every label is encoded by
  # prepending the size of the label to its name, terminating this with a NUL
  # byte. So without the root zone this gives us a maximum of 253 chars for the
  # label. Going further, if we want to have a domain consisting solely of
  # 1-byte labels, the maximum amount of labels we can have is 127.
  #
  # So this specifies the maximum recursion depth for the zoneType.
  maxNodes = 127;

  # These are the bare options and *NOT* a submodule, because we need to map
  # over the option names later. Please keep this in mind when changing
  # anything here that you also likely need to change the implementation of
  # zoneType later in this file.
  #
  # We use isZone as a flag to map the DNS hierarchy, so let's say we want to
  # provide the following zones:
  #
  #   org
  #   foo.example.org
  #   example.com
  #
  # ... and provide an internal zone configuration like:
  #
  #   zones.org.isZone = true;
  #   zones.org.example.records.a = "127.0.0.1";
  #   zones.org.example.foo.isZone = true;
  #   zones.com.example.subZones.xxx.subZones.bar.records.aaaa = "1234::5678";
  #
  # ... we get a tree like this:
  #
  #            root (z)
  #         /        \
  #      com (z)      org (Z)
  #     /                \
  #  example (Z)       example (z)
  #    |                  |
  #   xxx (z)           foo (Z)
  #    |
  #   bar (z)
  #
  # z: isZone = false
  # Z: isZone = true
  #
  # The rationale about this is that entries that are flagged with isZone being
  # false are either ordinary resource names or nothing at all if they are
  # attribute names down the root.
  #
  # In the tree above we have "com", which is not a zone neither is it a
  # resource name. We also have "example.com", which then descents down to
  # "xxx" and "bar" the same way as the root (defaulting to isZone = false).
  zoneOptions = nestLevel: {
    isZone = lib.mkOption {
      type = types.bool;
      internal = true;
      description = "Whether this domain is a zone.";
    };

    records = lib.mkOption {
      type = recordsType;
      internal = true;
      default = {};
      description = "Records for this zone.";
    };
  } // lib.optionalAttrs (nestLevel <= maxNodes) {
    subZones = lib.mkOption {
      type = types.attrsOf (zoneType (nestLevel + 1));
      internal = true;
      default = {};
      description = "Subzones or simple resource records.";
    };
  };

  zoneType = nestLevel: let
    # This is needed because we can't just use types.addCheck on submodules
    # because the submodule type has a self-reference in substSubModules which
    # doesn't get the additional check function.
    submoduleTypeWithCheck = check: opts: let
      wrapped = m: types.addCheck (types.submodule m) check;
    in (types.submodule opts) // { substSubModules = m: wrapped m; };

    # The actual submodule representing a potential zone.
    submod = submoduleTypeWithCheck isZoneSubmodule ({ name, options, ... }: {
      options = zoneOptions nestLevel;

      # Only if there is a SOA record, we do have a real zone, otherwise this
      # is just an ordinary resource record name.
      config.isZone = options.records ? SOA;
    });

    # Used for the coercion to determine whether this is actually the submodule
    # or just a plain attribute set of DNS labels.
    isZoneSubmodule = attrs: let
      hasOpts = builtins.intersectAttrs attrs (zoneOptions nestLevel) != {};
    in attrs == {} || hasOpts;

    # Coerces an attribute set to a submodule for the current zone so that we
    # can simply write out resource record types without the need to nest them
    # into another attribute set (in this case .records and .subZones).
    #
    # If somebody wants to have a record type or a label that collides with one
    # of the zone options, it's still possible to do this by defining
    # 'subZones' or 'records'.
    #
    # Note that instead of matching record types by the names of available
    # types, we only check whether the first letter is uppercase. The reason is
    # that we want to get a type error whenever we have mistyped a record type.
    coerceZone = attrs: let
      isRType = attrName: builtins.match "[A-Z].*" attrName != null;
      partitioned = lib.partition isRType (lib.attrNames attrs);
      mkDefs = lib.flip lib.genAttrs (name: attrs.${name});
    in rec {
      records = mkDefs partitioned.right;
      subZones = mkDefs partitioned.wrong;
    };

    # This creates our final type for the zone specification, which we're going
    # to wrap again to make sure that it doesn't get substituted with the
    # default implementation.
    mkFinalType = m: (types.coercedTo types.attrs coerceZone m) // {
      name = "dnsZone";
      description = "nested attribute set of DNS nodes";
      # Make sure we hide the internal options and provide only the record type
      # options, so that we get nice documentation.
      getSubOptions = prefix: recordsType.getSubOptions (prefix ++ [
        "<label1>" "<label2>" "<labelN>"
      ]);
    };

  in (mkFinalType submod) // {
    substSubModules = m: mkFinalType (submod.substSubModules m);
  };

in {
  options.nixcloud.dns.zones = lib.mkOption {
    type = zoneType 0;
    default = {};
    example = lib.literalExample (builtins.readFile ./example.nix);
    description = ''
      The DNS hierarchy of zones, where attribute names are labels and the
      values are either other labels or record types. Each label is annotated
      going town from the root zone, so <literal>example.com</literal> is
      <literal>com.example</literal> here.

      Record types are specified by using an upper-case name, such as
      <literal>AAAA</literal>.

      If you want to provide a DNS label with an upper-case name, it's
      necessary to directly reference the internal submodule which maps out the
      DNS hierarchy. The internal option <option>subZones</option> can be used
      for that, so let's say you want to have an <option>A</option> resource
      record for <literal>foo.AAAA.example.org</literal>, the option definition
      would be something like
      <literal>org.example.subZones.AAAA.foo.A = ...</literal>.

      Likewise, if you want to specify records for a DNS label called
      <literal>records</literal> this can be done by using the
      <option>subZones</option> option as well, using something like
      <literal>org.example.subzones.records.A = ...</literal>.
    '';
  };
}
