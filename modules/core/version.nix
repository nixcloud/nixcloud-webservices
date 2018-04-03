{ config, pkgs, lib, ... }:

let
  gitDir = toString ../../.git;
  hasGitDir = lib.pathIsDirectory gitDir;
  commitId = lib.commitIdFromGitRepo gitDir;
  abbrevId = lib.substring 0 7 commitId;
  version = if hasGitDir then commitId else "master";
  abbrevVersion = lib.optionalString hasGitDir "_${abbrevId}";

  nixcloudVersionScript = pkgs.writeScriptBin "nixcloud-version" ''
    #!${pkgs.stdenv.shell}
    echo ${lib.escapeShellArg config.nixcloud.version}
  '';

in {
  options.nixcloud.version = lib.mkOption {
    type = lib.types.str;
    internal = true;
    description = "The git revision of nixcloud-webservices.";
  };

  config.nixcloud.version = version;
  config.environment.systemPackages = lib.singleton nixcloudVersionScript;
  config.system.nixos.versionSuffix = let
    nixpkgsRev = lib.substring 0 7 config.system.nixos.revision;
  in ".${nixpkgsRev}-nixcloud${abbrevVersion}";
}
