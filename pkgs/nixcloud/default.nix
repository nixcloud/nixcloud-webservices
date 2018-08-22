{ pkgs, ... }:
{
  container = pkgs.stdenv.mkDerivation rec {
    name = "nixcloud-container-${version}";
    version = "0.0.1";

    src = pkgs.fetchFromGitHub {
      owner = "nixcloud";
      repo = "nixcloud-container";
      rev = "6c3d330560e52e7508f439cb7556ba2b62cb0cb4";
      sha256 = "0yz6gqih14hcqnapf3gm9d3zl5b0jbgim6q35ba435qizwajdm31";
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
