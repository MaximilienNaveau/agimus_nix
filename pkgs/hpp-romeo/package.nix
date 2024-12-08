{
  cmake,
  doxygen,
  fetchFromGitHub,
  fetchpatch,
  hpp-corbaserver,
  jrl-cmakemodules,
  lib,
  pkg-config,
  python3Packages,
  pythonSupport ? false,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-romeo";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp_romeo";
    rev = "v${finalAttrs.version}";
    hash = "sha256-lL2pCpjpgMW0K7cBRr97ozrGxec7mhsV5VqntqC8mIE=";
  };

  patches = [
    # Allow use without python
    (fetchpatch {
      url = "https://github.com/humanoid-path-planner/hpp_romeo/pull/24/commits/4513229bfc6887873083a03d5c395c6970639a89.patch";
      hash = "sha256-ChrEDRJiFVbwUhhTiFuE9GmkrMqMsc4Tn9d9MR+blS4=";
    })
  ];

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
  ++ lib.optional pythonSupport python3Packages.hpp-corbaserver
  ++ lib.optional (!pythonSupport) hpp-corbaserver;

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
  ];

  doCheck = true;

  meta = {
    description = "Python and ros launch files for Romeo robot in hpp";
    homepage = "https://github.com/humanoid-path-planner/hpp_romeo";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
