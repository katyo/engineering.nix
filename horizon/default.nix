{ stdenv
, lib
, fetchFromGitHub
, pkgconfig
, sqlite
, libyamlcpp
, libuuid
, gnome3
, epoxy
, librsvg
, zeromq
, cppzmq
, glm
, libgit2
, curl
, boost
, python3
, python3Packages
, opencascade
, libzip
, podofo
, wrapGAppsHook
, coreutils }:

stdenv.mkDerivation rec {
  pname = "horizon-eda";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "horizon-eda";
    repo = "horizon";
    #rev = "v${version}";
    rev = "d69b69c";
    #sha256 = "0b1bi99xdhbkb2vdb9y6kyqm0h8y0q168jf2xi8kd0z7kww8li2p"; #1.2.1
    sha256 = "1hd4in14x5wsy6dvi3xq7lh8hjlv0j1vym5cfwfqka9gkixvk5qp";
  };

  buildInputs = [
    boost
    cppzmq
    curl
    epoxy
    glm
    gnome3.gtkmm
    libgit2
    librsvg
    libuuid
    libyamlcpp
    libzip
    opencascade
    podofo
    python3
    sqlite
    zeromq
    python3Packages.pycairo
  ];

  nativeBuildInputs = [ pkgconfig wrapGAppsHook ];

  NIX_CFLAGS_COMPILE = "-I${opencascade}/include/oce";

  installPhase = ''
    make install INSTALL=${coreutils}/bin/install DESTDIR=$out PREFIX=
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "A free EDA software to develop printed circuit boards";
    homepage = "https://github.com/horizon-eda/horizon";
    maintainers = with maintainers; [ luz yrashk ];
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
