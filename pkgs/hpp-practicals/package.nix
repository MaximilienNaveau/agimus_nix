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
  pname = "hpp-practicals";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-practicals";
    rev = "v${finalAttrs.version}";
    hash = "sha256-JJFUhmWP3GTOeoZKZpezTPhYSC36iUlY5AOU5dBGD9I=";
  };

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
    python3Packages.hpp-gepetto-viewer
    python3Packages.hpp-gui
    python3Packages.hpp-plot
  ];

  doCheck = true;

  meta = {
    description = "Practicals for Humanoid Path Planner software";
    homepage = "https://github.com/humanoid-path-planner/hpp-practicals";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
