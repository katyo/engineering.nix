{ stdenv, pkgconfig, gtk, glib, gtkglext, libGLU, xorg, gvfs, gd, gettext, libxml2, libstroke, imagemagick, freetype, fuse, genht, fungw, makeDesktopItem, ... }:

stdenv.mkDerivation rec {
  pname = "pcb-rnd";
  version = "2.2.4";

  src = fetchTarball rec {
    url = "http://repo.hu/projects/${pname}/releases/${pname}-${version}.tar.bz2";
    sha256 = "03kbwn0m6w2vvxlxzpinhn389kf0vw3zhmwzzy55vrp55426max2";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [
    pkgconfig
    imagemagick
  ];

  buildInputs = [
    gtk
    glib
    gtkglext
    libGLU
    xorg.libXmu
    gvfs
    gd
    gettext
    libxml2
    libstroke
    freetype
    fuse
    fungw
    genht
  ];

  #propagatedBuildInputs = [
  #  lua
  #  python
  #];

  patches = [
    #./relative-lib-symlinks.patch
  ];

  configureFlags = [
    "--symbols"
    "--all=buildin"
    #"--CFLAGS='-I'"
    "--LDFLAGS='-L${fungw}/lib'"
    "--LDFLAGS='-L${genht}/lib'"
  ];

  CPATH = "${fungw}/include:${genht}/include:./src_3rd:${freetype.dev}/include/freetype";

  /*CFLAGS = [
    "-I${fungw}/include"
    "-I./src_3rd"
    "-I${freetype.dev}/include/freetype"
  ];

  LDFLAGS = [
    "-L${fungw}/lib"
    "-L${genht}/lib"
  ];*/
  #--CFLAGS='-I${fungw}/include -I$src/src_3rd -I${freetype.dev}/include/freetype' --LDFLAGS='-L${fungw}/lib -L${genht}/lib'";

  /*postInstall = let item = makeDesktopItem rec {
    name = "${pname}";
    exec = "${pname} %f";
    icon = "${pname}";
    comment = "A free EDA software to develop printed circuit boards";
    desktopName = "${pname}";
    genericName = "PCB Design";
    mimeType = "application/x-pcb-layout;application/x-pcb-footprint;";
    categories = "Engineering;Electronics;Development;";
  }; in ''
    mkdir -p $out/share/applications $out/share/pixmaps
    cp $src/${pname}.xpm $out/share/pixmaps
    ln -s ${item}/share/applications/* $out/share/applications
  '';*/

  meta = with stdenv.lib; {
    description = "A free EDA software to develop printed circuit boards";
    homepage = http://repo.hu/projects/pcb-rnd;
    maintainers = [ "kayo@illumium.org" ];
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
