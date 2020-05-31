{ stdenv, fetchFromGitHub, autoreconfHook, libmilter }:

stdenv.mkDerivation rec {
  pname = "opendmarc";
  version = "1.3.3";

  src = fetchFromGitHub {
    owner = "trusteddomainproject";
    repo = "opendmarc";
    rev = "rel-opendmarc-${builtins.replaceStrings [ "." ] [ "-" ] version}";
    sha256 = "sha256-SQH85FLfVEEtYhR1+A1XxCDMiTjDgLQX6zifbLxCa5c=";
  };

  outputs = [ "bin" "dev" "out" "doc" ];

  nativeBuildInputs = [ autoreconfHook ];

  postPatch = ''
    substituteInPlace configure.ac --replace '	docs/Makefile' ""
  '';

  configureFlags = [
    "--with-milter=${libmilter}"
  ];

  meta = with stdenv.lib; {
    description = "A free open source software implementation of the DMARC specification";
    homepage = "http://www.trusteddomain.org/opendmarc/";
    license = with licenses; [ bsd3 sendmail ];
    maintainers = with maintainers; [ ajs124 das_j ];
  };
}
