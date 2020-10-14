{ stdenv, pkgconfig, lua, python, perl, tcl, duktape, ... }:

stdenv.mkDerivation rec {
  pname = "fungw";
  version = "1.0.0";

  src = fetchTarball rec {
    url = "http://repo.hu/projects/${pname}/releases/${pname}-${version}.tar.bz2";
    sha256 = "15v7imjnz0c6pb6d3pz7a9vv725d0vmxckj0abhwxzxjmihgqf5x";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [
    pkgconfig
  ];

  buildInputs = [
    lua
    python
    perl
    tcl
    duktape
  ];

  configureFlags = [
    "--LDFLAGS=-lpthread"
  ];

  patches = [
    ./fix-python-lib-name.patch
  ];

  meta = with stdenv.lib; {
    description = "Function gateway library";
    homepage = http://repo.hu/projects/fungw;
    maintainers = [ "kayo@illumium.org" ];
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
