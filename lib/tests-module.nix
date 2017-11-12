{ pkgs, config, lib, ... }:

with lib;

{
  options = {
    tests = mkOption {
      type = types.unspecified; #types.listOf types.package;
      default = [];
      description = ''
        TODO
        A list of derivations that test the module.
        Those ofentimes use <literal>nixos/lib/testing</literal>,
        but are not forced to do so.
      '';
    };

    mymodule.enable = mkEnableOption "test";
  };

  config = mkIf config.mymodule.enable {
    tests = [
      (derivation {
        name = "test11";
        inherit (pkgs) system;
        builder = pkgs.writeScript "builder" ''
          #!/bin/sh

          echo ich werde failen
          echo hello > $out
          exit 1
        '';
      })
    ];
  };
}
# nix-build -E '(import <nixpkgs/nixos/lib/eval-config.nix> { modules = [./tests-module.nix]; }).config.tests'

#nix-repl> config.tests
#{ foo = [ ... ]; }
#nix-repl> :b head config.tests.foo/nix/store/inxdkbajj3l03ysv8rz5wyyr847jj55g-test1
