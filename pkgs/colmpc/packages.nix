{
  cmake,
  doxygen,
  pkg-config,
  boost,
  eigen,
  crocoddyl,
  hpp-constraints,
  fetchFromGitHub,
  pythonSupport ? false,
  python3Packages,
  lib,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "colmpc";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "agimus-project";
    repo = "colmpc";
    rev = "v${finalAttrs.version}";
    hash = "sha256-GzlQ4kfiMUf9qVP5t+/qoQZbBIOe1JPdmL7+86dJVaQ=";
  };

  strictDeps = true;

  nativeBuildInputs =
    [
        cmake
        doxygen
        pkg-config
    ]
    ++ lib.optionals pythonSupport [
      python3Packages.numpy
      python3Packages.pythonImportsCheckHook
    ];

  propagatedBuildInputs =
    [
        boost
        crocoddyl
    ]
    ++ lib.optionals (!pythonSupport) [
      boost
      eigen
    ]
    ++ lib.optionals pythonSupport [
      python3Packages.boost
      python3Packages.eigenpy
      python3Packages.crocoddyl
    ];

  cmakeFlags = [
    (lib.cmakeBool "INSTALL_DOCUMENTATION" true)
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
  ];

  doCheck = true;

  meta = {
    description = "Collision Residual for Crocoddyl.";
    homepage = "https://github.com/agimus-project/colmpc";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})