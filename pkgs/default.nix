{ pkgs ? import <nixpkgs> {} }:

let
  self = {
    callPackage = pkgs.newScope self;

    nixcloud = import ./nixcloud {
      inherit (self) callPackage;
      inherit pkgs;
    };
  };

in self
