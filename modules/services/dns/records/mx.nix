{ config, lib, dnsLib, ... }:

let
  inherit (lib) types mkOption;
in {
  options.preference = mkOption {
    type = types.ints.u16;
    default = 0;
    example = 10;
    description = ''
      Specifies the preference given to this resource record among others at
      the same owner. Lower values are preferred.
    '';
  };

  options.exchange = mkOption {
    type = dnsLib.types.domain;
    example = "mailserver.example.org.";
    description = ''
      A domain name which specifies a host willing to act as a mail exchange
      for the owner name.
    '';
  };

  config.record.rdata = [
    (toString config.preference)
    config.exchange
  ];
}
