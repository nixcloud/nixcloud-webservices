{ stdenv, fetchFromGitHub, pkgconfig }:

stdenv.mkDerivation rec {
  name = "taiga-front-dist-${version}";
  version = "3.3.13-stable";

  src = fetchFromGitHub {
    owner = "taigaio";
    repo = "taiga-front-dist";
    rev = "${version}";
    sha256 = "1692s4fz7kcxqsi5pacz1n1am14nx2c0wr5h1yzc6hg0p0aknfbr";
  };

  installPhase = ''
    mkdir -p $out
    mv * $out/
  '';

  meta = {
    description = "Project management web application with scrum in mind! Built on top of Django and AngularJS (Front)";
    inherit (src.meta) homepage;
    license = stdenv.lib.licenses.agpl3;
    maintainers = [];
  };
}
