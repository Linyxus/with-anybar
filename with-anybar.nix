{ mkDerivation, array, base, bytestring, containers, lens
, megaparsec, mtl, optparse-applicative, parser-combinators
, process, stdenv, text
}:
mkDerivation {
  pname = "with-anybar";
  version = "1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    array base bytestring containers lens megaparsec mtl
    optparse-applicative parser-combinators process text
  ];
  license = stdenv.lib.licenses.bsd3;
}
