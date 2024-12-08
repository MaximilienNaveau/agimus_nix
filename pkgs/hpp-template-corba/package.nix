{
  cmake,
  fetchFromGitHub,
  hpp-util,
  jrl-cmakemodules,
  lib,
  omniorb,
  pkg-config,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-template-corba";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-template-corba";
    rev = "v${finalAttrs.version}";
    hash = "sha256-JlN/7QzbTlvX2CBgTpCCGt3b+9Nxgotp4xdIK35xFBQ=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    pkg-config
    omniorb
  ];
  propagatedBuildInputs = [
    jrl-cmakemodules
    hpp-util
    omniorb
  ];

  doCheck = true;

  meta = {
    description = "This package is intended to ease construction of CORBA servers by templating actions that are common to all servers";
    homepage = "https://github.com/humanoid-path-planner/hpp-template-corba";
    license = lib.licenses.bsd3;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
