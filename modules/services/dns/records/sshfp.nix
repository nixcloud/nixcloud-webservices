{ config, lib, dnsLib, domain, ... }:

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
    type = lib.mkOptionType {
      name = "hexEncodedHash";
      description = "hex-encoded hash";
      check = x: lib.isString x
              && builtins.match "([a-fA-F0-9]{2})+" x != null;
      merge = lib.mergeOneOption;
    };
    example = "c56e95d1a3015e55ad38b25e59867dc5d12f73ca";
    description = "The fingerprint of the public key.";
  };

  config.assertions = lib.mapAttrsToList (hashType: reqiredLen: {
    assertion = config.hashType == hashType
             -> lib.stringLength config.fingerprint == reqiredLen;
    message = "The SSHFP fingerprint '${config.fingerprint}' on domain"
            + " '${lib.concatStringsSep "." domain}' is of type"
            + " '${config.hashType}' so it needs to have a length of"
            + " ${toString reqiredLen} characters but it has a length of"
            + " ${toString (lib.stringLength config.fingerprint)} characters"
            + " instead.";
  }) {
    sha1 = 40;
    sha256 = 64;
  };

  config.record.rdata = [
    (toRR config.algorithm mappings.algorithm)
    (toRR config.hashType mappings.hashType)
    config.fingerprint
  ];
}
