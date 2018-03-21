{ options, config, lib, dnsLib, ... }:

let
  inherit (lib) types mkOption;
in {
  options.critical = mkOption {
    type = types.bool;
    default = false;
    description = ''
      If set to <literal>true</literal>, indicates that the values specified in
      either <option>issue</option>, <option>issueWild</option>,
      <option>iodef</option> or <option>properties</option> must be fully
      understood by the issuer, otherwise issuers must not issue certificates
      for this domain.
    '';
  };

  options.issue = mkOption {
    type = dnsLib.types.domain;
    example = "ca.example.org";
    description = ''
      Authorizes the holder of the given domain name or a party acting under
      the explicit authority of the holder of that domain name to issue
      certificates for the current domain.

      The given domain name has to be a fully qualified domain name.
    '';
  };

  options.issueWild = mkOption {
    type = dnsLib.types.domain;
    example = "ca.example.org";
    description = ''
      Authorizes the holder of the given domain name or a party acting under
      the explicit authority of the holder of that domain name to issue
      wildcard certificates for the current domain.

      The given domain name has to be a fully qualified domain name.
    '';
  };

  options.iodef = mkOption {
    type = types.str;
    example = "mailto:security@example.net";
    description = ''
      Specifies a URL to which an issuer may report certificate issue requests
      that are inconsistent with the issuer's certification practices or
      certificate policy, or that a certificate evaluator may use to report
      observation of a possible policy violation.
    '';
  };

  options.properties = mkOption {
    type = types.attrsOf types.str;
    default = {};
    example.account = "230123";
    example.policy = "ev";
    description = ''
      These are custom properties that might be specific to an issuer, like for
      example to ensure that only extended validation certificates are issued.
    '';
  };

  config.record.rdata = let
    mutualOpts = [ "issue" "issueWild" "iodef" ];
    optsDefined = lib.filter (o: options.${o}.isDefined) mutualOpts;
    tooMany = "More than one option of issue, issueWild or iodef are defined.";
    assertTooMany = x: if lib.length optsDefined > 1 then throw tooMany else x;
    tooFew = "None of issue, issueWild or iodef options are defined.";
    assertTooFew = x: if optsDefined == [] then throw tooFew else x;
    definedOpt = lib.head (assertTooMany (assertTooFew optsDefined));
    isIssue = definedOpt == "issue" || definedOpt == "issueWild";
    cfgValue = config.${definedOpt};
    extractDomain = d: lib.concatStringsSep "." (d.absolute or d.relative);
    mainProp = if isIssue then extractDomain cfgValue else cfgValue;
    extraPropList = lib.mapAttrsToList (k: v: "${k}=${v}") config.properties;
    extraProps = lib.concatStringsSep "; " extraPropList;
    hasExtra = config.properties != {};
    props = mainProp + lib.optionalString hasExtra "; ${extraProps}";
  in [
    (if config.critical then "128" else "0")
    (if definedOpt == "issueWild" then "issuewild" else definedOpt)
    props
  ];
}
