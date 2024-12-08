{
  cmake,
  doxygen,
  fetchFromGitHub,
  hpp-fcl,
  jrl-cmakemodules,
  lib,
  pkg-config,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-affordance";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-affordance";
    rev = "v${finalAttrs.version}";
    hash = "sha256-RCpc+rNs9khy3LGKmiTuqQ8P7dJtdqAYvLU4yq9OiEU=";
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
    hpp-fcl
    jrl-cmakemodules
  ];

  meta = {
    description = "Implements affordance extraction for multi-contact planning";
    homepage = "https://github.com/humanoid-path-planner/hpp-affordance";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
