{ pkgs, ... }:
{
  container = pkgs.stdenv.mkDerivation rec {
    name = "nixcloud-container-${version}";
    version = "0.0.1";

    src = pkgs.fetchFromGitHub {
      owner = "nixcloud";
      repo = "nixcloud-container";
      rev = "4d2c527f825d1365a432ca1b7e66ffab7754a237";
      sha256 = "11pvhpdg5ipxy98sq0laxc3bbgbahhkbbvbjygx6k4jknkk5bmm5";
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
