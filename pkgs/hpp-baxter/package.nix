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
  pname = "hpp-baxter";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-baxter";
    rev = "v${finalAttrs.version}";
    hash = "sha256-hhb/ZxjU5OO6mV1vlcOY02gObArchqq+jaI5pZsgMO0=";
  };

  patches = [
    # Allow use without python
    (fetchpatch {
      url = "https://github.com/humanoid-path-planner/hpp-baxter/pull/30/commits/7c2f69a9b2ec08c3f03aabd3d7b2a0964113c475.patch";
      hash = "sha256-ON3aAPToDdGHTXD/OFLMq1vK4NGSWpfK9F5hikJEm6w=";
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
    description = "Wrappers for Baxter robot in HPP";
    homepage = "https://github.com/humanoid-path-planner/hpp-baxter";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
      platforms = lib.platforms.unix;
  };
})
