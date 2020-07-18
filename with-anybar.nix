{ mkDerivation, base, bytestring, containers, directory, mtl
, network, process, stdenv, text
}:
mkDerivation {
  pname = "with-anybar";
  version = "1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base bytestring containers directory mtl network process text
  ];
  license = stdenv.lib.licenses.bsd3;
}
