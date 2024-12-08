{
  boost,
  cmake,
  doxygen,
  example-robot-data,
  fetchFromGitHub,
  jrl-cmakemodules,
  lib,
  pkg-config,
  pinocchio,
  python3Packages,
  pythonSupport ? false,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-environments";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-environments";
    rev = "v${finalAttrs.version}";
    hash = "sha256-ajfsBa57ORnkhtLgolKT+GQNQJ7IQWwDGsadidrm9sY=";
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
  ] ++ lib.optional pythonSupport python3Packages.python;
  propagatedBuildInputs = [
    jrl-cmakemodules
  ]
    ++ lib.optionals pythonSupport [
    python3Packages.boost
    python3Packages.eigenpy
    python3Packages.pinocchio
    python3Packages.example-robot-data
  ]
  ++ lib.optionals (!pythonSupport) [
    boost
    pinocchio
    example-robot-data
  ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
  ];


  doCheck = true;

  meta = {
    description = "Environments and robot descriptions for HPP";
    homepage = "https://github.com/humanoid-path-planner/hpp-environments";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
