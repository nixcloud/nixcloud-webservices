{pkgs ? import <nixpkgs> {
  inherit system;
}, system ? builtins.currentSystem}:

let
  nodePackages = import ./default.nix {
    inherit pkgs system;
  };
in
nodePackages // {
  TaigaIO-Events = nodePackages.package.override {
    src = pkgs.fetchFromGitHub {
      owner = "taigaio";
      repo = "taiga-events";
      rev = "3583834aba595006f290928470b91bd6e2a71a9e";
      sha256 = "036r23fd0srcilrs7cm403sqq9l56cikk5z3h5ymqbcn2rb90zjm";
    };
  };
}
