{
  cmake,
  doxygen,
  fetchFromGitHub,
  lib,
  libsForQt5,
  pkg-config,
  python3Packages,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-doc";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-doc";
    rev = "v${finalAttrs.version}";
    hash = "sha256-VvddV7/R+Rkw1l8zPrMpOisZrua1KKQPPtke1lUppvo=";
  };

  prePatch = ''
    substituteInPlace scripts/auto-install-hpp.sh \
      --replace-fail /bin/bash ${stdenv.shell}
    substituteInPlace scripts/install-tar-on-remote \
      --replace-fail /bin/bash ${stdenv.shell}
    substituteInPlace scripts/generate-tar-doc \
      --replace-fail /bin/sh ${stdenv.shell}
    substituteInPlace scripts/packageDep \
      --replace-fail /usr/bin/python ${python3Packages.python.interpreter}
  '';

  outputs = [
    "out"
    "doc"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    libsForQt5.wrapQtAppsHook
    pkg-config
    python3Packages.python
  ];
  buildInputs = [ libsForQt5.qtbase ];
  propagatedBuildInputs = [
    python3Packages.hpp-practicals
    python3Packages.hpp-tutorial
  ];

  doCheck = true;

  meta = {
    description = "Documentation for project Humanoid Path Planner";
    homepage = "https://github.com/humanoid-path-planner/hpp-doc";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
