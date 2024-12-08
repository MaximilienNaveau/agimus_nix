{
  cddlib,
  clp,
  cmake,
  doxygen,
  fetchFromGitHub,
  glpk,
  hpp-centroidal-dynamics,
  lib,
  ndcurves,
  pkg-config,
  python3Packages,
  pythonSupport ? false,
  qpoases,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-bezier-com-traj";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-bezier-com-traj";
    rev = "v${finalAttrs.version}";
    hash = "sha256-o+bLMrVQNW117ZGhmOpi9jAh/TY8vvbbzlzVDSgkGo0=";
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
  ] ++ lib.optionals pythonSupport [
    python3Packages.python
    python3Packages.pythonImportsCheckHook
  ];
  propagatedBuildInputs = [
    cddlib
    clp
    glpk
    qpoases
  ] ++ lib.optionals pythonSupport [
    python3Packages.hpp-centroidal-dynamics
    python3Packages.ndcurves
  ] ++ lib.optionals (!pythonSupport) [
    hpp-centroidal-dynamics
    ndcurves
  ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
    (lib.cmakeBool "USE_GLPK" true)
  ];

  doCheck = true;

  pythonImportsCheck = [ "hpp_bezier_com_traj" ];

  meta = {
    description = "Multi contact trajectory generation for the COM using Bezier curves";
    homepage = "https://github.com/humanoid-path-planner/hpp-bezier-com-traj";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
