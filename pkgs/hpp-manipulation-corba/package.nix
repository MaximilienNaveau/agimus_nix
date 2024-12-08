{
  cmake,
  doxygen,
  fetchFromGitHub,
  hpp-manipulation-urdf,
  lib,
  omniorb,
  pkg-config,
  python3Packages,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-manipulation-corba";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-manipulation-corba";
    rev = "v${finalAttrs.version}";
    hash = "sha256-QTD+aXURL+dCG3ZbFH4Q2X6TQhOP8sq11xkWtKCM5EU=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    omniorb
    pkg-config
    python3Packages.python
  ];
  propagatedBuildInputs = [
    hpp-manipulation-urdf
    python3Packages.hpp-corbaserver
    python3Packages.omniorbpy
  ];

  enableParallelBuilding = false;

  doCheck = true;

  meta = {
    description = "Corba server for manipulation planning";
    homepage = "https://github.com/humanoid-path-planner/hpp-manipulation-corba";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
