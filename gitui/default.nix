{ fetchzip, stdenv, ... }:
let package = {
  x86_64-linux = {
    name = "linux-musl";
    hash = "1ay0y8q22gfzd3703n5i65rc6mqfjhi17v4hpl4fg1pz43mkg167";
  };
  x86_64-darwin = {
    name = "mac";
    hash = "";
  };
  x86_64-windows = {
    name = "win";
    hash = "";
  };
}.${stdenv.targetPlatform.system};
in stdenv.mkDerivation rec {
  pname = "gitui";
  version = "0.13.0";
  src = fetchzip {
    url = "https://github.com/extrawurst/${pname}/releases/download/v${version}/${pname}-${package.name}.tar.gz";
    sha256 = "${package.hash}";
  };
  installPhase = ''
    install -d $out/bin
    install -m755 $src/gitui $out/bin
  '';
}
