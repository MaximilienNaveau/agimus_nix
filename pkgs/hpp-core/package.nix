{
  cmake,
  doxygen,
  fetchFromGitHub,
  fetchpatch,
  hpp-constraints,
  lib,
  pkg-config,
  proxsuite,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hpp-core";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "humanoid-path-planner";
    repo = "hpp-core";
    rev = "v${finalAttrs.version}";
    hash = "sha256-GzlQ4kfiMUf9qVP5t+/qoQZbBIOe1JPdmL7+86dJVaQ=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/humanoid-path-planner/hpp-core/pull/347/commits/7b76c7019dc5424ec85d3be33927240b709cc8dd.patch";
      hash = "sha256-smhukV7OYxste+GgmRFz2QLtohVqyGZaQbvQcneY0cI=";
    })
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    pkg-config
  ];
  propagatedBuildInputs = [
    hpp-constraints
    proxsuite
  ];

  doCheck = true;

  meta = {
    description = "The core algorithms of the Humanoid Path Planner framework";
    homepage = "https://github.com/humanoid-path-planner/hpp-core";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
    platforms = lib.platforms.unix;
  };
})
