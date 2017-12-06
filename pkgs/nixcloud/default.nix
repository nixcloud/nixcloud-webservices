{ pkgs, ... }:
{
  container = pkgs.stdenv.mkDerivation rec {
    name = "nixcloud-container-${version}";
    version = "0.0.1";
  
    src = pkgs.fetchFromGitHub {
      owner = "nixcloud";
      repo = "nixcloud-container";
      rev = "92d9ca28ab0377c411249bcf27f2f2de6df1de23";
      sha256 = "191zqr9glkb3ycmilg6dvm75shdm3h0i9jjmfgx1ff47ykb1lrd2";
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
