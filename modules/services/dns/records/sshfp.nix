{ config, lib, dnsLib, ... }:

let
  inherit (lib) types mkOption;

  # https://www.iana.org/assignments/dns-sshfp-rr-parameters/
  mappings = {
    algorithm.rsa     = 1;
    algorithm.dsa     = 2;
    algorithm.ecdsa   = 3;
    algorithm.ed25519 = 4;

    hashType.sha1   = 1;
    hashType.sha256 = 2;
  };

  enumDoc = mapping: ''
    <variablelist>
      ${lib.concatStrings (lib.flip lib.mapAttrsToList mapping (option: num: ''
        <varlistentry>
          <term><option>${option}</option></term>
          <listitem><para>${toString num}</para></listitem>
        </varlistentry>
      ''))}
    </variablelist>
  '';

  toRR = def: mapping: let
    mappingValue = toString mapping.${def};
  in if lib.isInt def then toString def else mappingValue;

in {
  options.algorithm = mkOption {
    type = types.either types.ints.unsigned (types.enum [
      "rsa" "dsa" "ecdsa" "ed25519"
    ]);
    default = "rsa";
    example = "ed25519";
    description = ''
      The algorithm of the public key, where the following names are available:

      ${enumDoc mappings.algorithm}
    '';
  };

  options.hashType = mkOption {
    type = types.either types.ints.unsigned (types.enum [
      "sha1" "sha256"
    ]);
    default = "sha256";
    example = "sha1";
    description = ''
      The message-digest algorithm used to calculate the fingerprint.

      Available options:

      ${enumDoc mappings.hashType}
    '';
  };

  options.fingerprint = mkOption {
    type = types.str;
    example = "d7e6cd1e6a10faec05e9ef42f95a157b6ec797a7";
    description = "The fingerprint of the public key.";
  };

  config.record.rdata = [
    (toRR config.algorithm mappings.algorithm)
    (toRR config.hashType mappings.hashType)
    config.fingerprint
  ];
}
