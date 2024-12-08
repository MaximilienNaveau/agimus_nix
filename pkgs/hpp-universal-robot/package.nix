{
  cmake,
  doxygen,
  example-robot-data,
  fetchFromGitHub,
  fetchpatch,
  jrl-cmakemodules,
  lib,
  pkg-config,
  python3Packages,
  pythonSupport ? false,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-universal-robot";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-universal-robot";
    rev = "v${finalAttrs.version}";
    hash = "sha256-Fyq7P+YZDGUKxOrif0id1WIeMKu5o/7FM+CRpBCPC2A=";
  };

  patches = [
    # Allow use without python
    (fetchpatch {
      url = "https://github.com/humanoid-path-planner/hpp-universal-robot/pull/44/commits/f54965915dd143194c818d606fe36bf70b123726.patch";
      hash = "sha256-Bml9Pv13MTUMjXww2FLeJ98NDc26i3oUCOXIOD+XvE8=";
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
    example-robot-data
  ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_PYTHON_INTERFACE" pythonSupport)
  ];

  doCheck = true;

  meta = {
    description = "Data specific to robots ur5 and ur10 for hpp-corbaserver";
    homepage = "https://github.com/humanoid-path-planner/hpp-universal-robot";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
