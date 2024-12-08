{
  cmake,
  doxygen,
  fetchFromGitHub,
  lib,
  omniorb,
  pkg-config,
  python3Packages,
}:

python3Packages.buildPythonPackage {
  pname = "hpp-task-sequencing";
  version = "0-unstable-2024-09-02";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "nim65s";
    repo = "hpp-task-sequencing";
    rev = "30febaf464fc091c7173a909b06e6251847cee2e";
    hash = "sha256-m8Lpjmd+BYtgX7cnZ7P6XvTrjyTrXGQow5IKUPjz5YI=";
  };

  outputs = [
    "out"
    "doc"
  ];

  enableParallelBuilding = false;

  nativeBuildInputs = [
    doxygen
    cmake
    omniorb
    pkg-config
  ];
  propagatedBuildInputs = [ python3Packages.hpp-corbaserver ];

  meta = {
    description = "Compute sequence of motions to achieve a set of tasks";
    homepage = "https://github.com/florent-lamiraux/hpp-task-sequencing";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
  };
}
