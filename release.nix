{ system ? builtins.currentSystem, nixpkgs ? <nixpkgs> }:

let
  lib = import "${nixpkgs}/lib";

in {
  tests = let
    mkJob = lib.const lib.hydraJob;
    mapHydra = lib.mapAttrsRecursiveCond (t: !(t ? test)) mkJob;
  in mapHydra (import ./tests {
    inherit system;
    pkgs = import nixpkgs {};
  });
}
