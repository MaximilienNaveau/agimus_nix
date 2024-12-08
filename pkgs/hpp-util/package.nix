{
  boost,
  cmake,
  doxygen,
  fetchFromGitHub,
  fetchpatch,
  lib,
  jrl-cmakemodules,
  pkg-config,
  stdenv,
  tinyxml-2,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-util";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-util";
    rev = "v${finalAttrs.version}";
    hash = "sha256-cYONa7WTagNZCITtocdII+WcfdzZnvznFUyb7YLodIw=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/humanoid-path-planner/hpp-util/pull/68/commits/e67e465c06d81ce13bcd11441f777ca8b02fa7be.patch";
      hash = "sha256-C2coY1CBu4bONnas4GPZImyxuImBZ+HVIE1qdMdL9uM=";
    })
  ];

  prePatch = ''
    substituteInPlace tests/run_debug.sh.in \
      --replace-fail /bin/bash ${stdenv.shell}
  '';

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
    boost
    jrl-cmakemodules
    tinyxml-2
  ];

  doCheck = true;

  meta = {
    description = "Debugging tools for the HPP project";
    homepage = "https://github.com/humanoid-path-planner/hpp-util";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
