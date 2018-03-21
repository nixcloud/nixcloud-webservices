{ config, lib, dnsLib, ... }:

let
  inherit (lib) types mkOption;
in {
  options.mname = mkOption {
    type = dnsLib.types.domain;
    default = "ns";
    example = "ns.example.org";
    description = ''
      The domain name of the name server that was the original or primary
      source of data for this zone.
    '';
  };

  options.rname = mkOption {
    type = dnsLib.types.domain;
    default = "dnsadmin";
    example = "admin.example.org";
    description = ''
      A domain name which specifies the mailbox of the person responsible
      for this zone.
    '';
  };

  options.serial = mkOption {
    type = types.nullOr types.int;
    default = 0;
    example = 19700101;
    description = ''
      The unsigned 32 bit version number of the original copy of the
      zone. Zone transfers preserve this value. This value wraps and will
      be compared using sequence space arithmetic.

      <note><para>The value <literal>null</literal> automatically generates
      generates a serial entry, which depends on the zone generation module.
      If you run multiple name servers with are serving the same zone but are
      otherwise independent of each other (no zone transfer), you might want to
      set this to some constant value, because you might run into
      synchronization issues otherwise.</para></note>
    '';
  };

  options.refresh = mkOption {
    type = types.int;
    default = 28800;
    description = ''
      A 32 bit time interval before the zone should be refreshed.
    '';
  };

  options.retry = mkOption {
    type = types.int;
    default = 7200;
    description = ''
      A 32 bit time interval that should elapse before a failed refresh
      should be retried.
    '';
  };

  options.expire = mkOption {
    type = types.int;
    default = 604800;
    description = ''
      A 32 bit time value that specifies the upper limit on the time
      interval that can elapse before the zone is no longer
      authoritative.
    '';
  };

  options.minimum = mkOption {
    type = types.int;
    default = 86400;
    description = ''
      The unsigned 32 bit minimum TTL field that should be exported with
      any resource record from this zone.
    '';
  };

  config.record.rdata = [
    config.mname
    config.rname
    (if config.serial == null then {
      autoSerial = true;
    } else toString config.serial)
    (toString config.refresh)
    (toString config.retry)
    (toString config.expire)
    (toString config.minimum)
  ];
}
