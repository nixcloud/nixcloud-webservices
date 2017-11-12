{ config, lib, modulesPath, ... }:

let
  inherit (lib) types mkOption;
  cfg = config.nixcloud.assertions;

  mkAssertion = path: expectedHash: let
    contents = builtins.readFile "${toString modulesPath}/${toString path}";
    hash = builtins.hashString "sha256" contents;
  in {
    assertion = hash == expectedHash;
    message = "Hash mismatch for `${path}': "
            + "Expected `${expectedHash}' but got `${hash}'.";
  };

  hashType = lib.mkOptionType {
    name = "sha256";
    description = "base-16 SHA-256 hash";
    check = val: lib.isString val
              && builtins.match "[a-fA-F0-9]{64}" val != null;
    merge = lib.mergeOneOption;
  };

in {
  options.nixcloud.assertions.moduleHashes = mkOption {
    type = types.attrsOf hashType;
    default = {};
    example."services/mail/opendkim.nix" =
      "a937be8731e6e1a7b7872a2dc72274b4a31364f249bfcf8ef7bcc98753c9a018";
    description = ''
      An attribute set consisting of module paths relative to the NixOS module
      directory as attribute names and their corresponding SHA-256 hashes as
      attribute values.
    '';
  };

  config.assertions = lib.mapAttrsToList mkAssertion cfg.moduleHashes;
}
