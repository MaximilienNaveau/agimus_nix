{
  cmake,
  doxygen,
  fetchFromGitHub,
  hpp-pinocchio,
  hpp-statistics,
  lib,
  pkg-config,
  qpoases,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-constraints";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-constraints";
    rev = "v${finalAttrs.version}";
    hash = "sha256-o21bntcWaC5zNXPYjPB2RmS/EDOpFNdQVH/qX9481Do=";
  };

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    pkg-config
  ];
  propagatedBuildInputs = [
    hpp-pinocchio
    hpp-statistics
    qpoases
  ];

  doCheck = true;

  meta = {
    description = "Definition of basic geometric constraints for motion planning";
    homepage = "https://github.com/humanoid-path-planner/hpp-constraints";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
