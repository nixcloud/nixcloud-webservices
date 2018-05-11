{ config, pkgs, lib, ... }:

let
  gitDir = toString ../../.git;
  hasGitDir = lib.pathIsDirectory gitDir;
  commitId = lib.commitIdFromGitRepo gitDir;

  nixcloudVersionScript = pkgs.writeScriptBin "nixcloud-version" ''
    #!${pkgs.stdenv.shell}
    echo ${lib.escapeShellArg config.nixcloud.version}
  '';

in {
  options.nixcloud.version = lib.mkOption {
    type = lib.types.str;
    default = if hasGitDir then commitId else "master";
    internal = true;
    description = "The git revision of nixcloud-webservices.";
  };

  config.environment.systemPackages = lib.singleton nixcloudVersionScript;
  config.system.nixos.versionSuffix = let
    nixpkgsRev = lib.substring 0 7 config.system.nixos.revision;
    abbrevVersion =  lib.substring 0 7 config.nixcloud.version;
  in ".${nixpkgsRev}-nixcloud_${abbrevVersion}";
}
