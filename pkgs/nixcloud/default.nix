{ pkgs, ... }:
{
  lego = pkgs.callPackage ./lego/default.nix {};
  container = pkgs.stdenv.mkDerivation rec {
    name = "nixcloud-container-${version}";
    version = "0.0.1";

    src = pkgs.fetchFromGitHub {
      owner = "nixcloud";
      repo = "nixcloud-container";
      rev = "c47cc88172c869d23f1096a3d98e63150fe2b14f";
      sha256 = "1qdn64jhg9yibyqn498xy7c5byw61pmr0wy6jv56j7fj6gaac1m5";
    };

    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      mkdir -p $out/bin
      cp -r $src/bin/* $out/bin
      mkdir -p $out/share
      cp -r $src/test.nix $out/share
      # FIXME/HACK nixos-container should probably be run from a 'interactive shell' which already contains a valid
      #            NIX_PATH set (note: the NIX_PATH currently set points to a none-existing path, WTH?)
      #            or
      #            we should abstract over 'nix-channel' and for instance also push updates when they are avialbel ASAP
      wrapProgram $out/bin/nixcloud-container \
        --prefix PATH : "${pkgs.stdenv.lib.makeBinPath [ pkgs.lxc pkgs.nix pkgs.eject ]}" # eject because of util-linux and flock
    '';
  };
}
