{ config, lib, dnsLib, ... }:

let
  inherit (lib) types mkOption;
in {
  options.priority = mkOption {
    type = types.ints.u16;
    default = 0;
    example = 10;
    description = ''
      The priority of the host specified in <option>target</option>.
      Clients will always contact the target with the lowest priority it can
      reach.
    '';
  };

  options.weight = mkOption {
    type = types.ints.u16;
    default = 0;
    example = 100;
    description = ''
      Specifies a relative weight for entries with the same priority.

      Larger weights are given a proportionately higher probability of being
      selected.

      In the presence of records containing weights greater than 0, records
      with weight 0 should have a very small chance of being selected.
    '';
  };

  options.port = mkOption {
    type = types.ints.u16;
    example = 5222;
    description = ''
      The port to be used for contacting the <option>target</option>.
    '';
  };

  options.target = mkOption {
    type = dnsLib.types.domain;
    example = "server.example.org.";
    description = ''
      The domain name of the target host.

      A target of <literal>.</literal> means that the service is decidedly not
      available at this domain.
    '';
  };

  config.record.rdata = [
    (toString config.priority)
    (toString config.weight)
    (toString config.port)
    config.target
  ];
}
