{ stdenv, ... }:

stdenv.mkDerivation rec {
  pname = "genht";
  version = "1.0.1";

  src = fetchTarball rec {
    url = "http://repo.hu/projects/${pname}/releases/${pname}-${version}.tar.bz2";
    sha256 = "1pp3bhmjflqr7vn9nzxm47grxgyijawpv0cip1rn5j5rm4b6rnn1";
  };

  enableParallelBuilding = true;

  installPhase = ''
    cd src && make DESTDIR=$out install
  '';

  patches = [
    ./fix-install-path.patch
  ];

  meta = with stdenv.lib; {
    description = "Generic hashtable library";
    homepage = http://repo.hu/projects/genht;
    maintainers = [ "kayo@illumium.org" ];
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
