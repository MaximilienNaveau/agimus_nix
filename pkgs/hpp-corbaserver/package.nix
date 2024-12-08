{
  cmake,
  doxygen,
  fetchFromGitHub,
  hpp-core,
  hpp-template-corba,
  lib,
  makeWrapper,
  omniorb,
  pkg-config,
  psmisc,
  python3Packages,
  runCommand,
  stdenv,
}:
let
  hpp-corbaserver = stdenv.mkDerivation (finalAttrs: {
    pname = "hpp-corbaserver";
    version = "5.1.0";

    src = fetchFromGitHub {
      owner = "humanoid-path-planner";
      repo = "hpp-corbaserver";
      rev = "v${finalAttrs.version}";
      hash = "sha256-qFcBT/YDTsrAzEE//JmCbk1TnVrnYcme1WCzkPaXwZ0=";
    };

    prePatch = ''
      substituteInPlace tests/hppcorbaserver.sh \
        --replace-fail /bin/bash ${stdenv.shell}
    '';

    outputs = [
      "out"
      "doc"
    ];

    nativeBuildInputs = [
      cmake
      doxygen
      omniorb
      pkg-config
      python3Packages.pythonImportsCheckHook
    ];
    propagatedBuildInputs = [
      hpp-core
      hpp-template-corba
      python3Packages.omniorbpy
    ];
    checkInputs = [
      psmisc
      python3Packages.numpy
    ];

    enableParallelBuilding = false;

    # psmisc is only available on linux
    doCheck = stdenv.isLinux;

    pythonImportsCheck = [ "hpp.corbaserver" ];

    passthru.withPlugins =
      plugins:
      runCommand "hppcorbaserver" { nativeBuildInputs = [ makeWrapper ]; } ''
        makeWrapper ${lib.getExe hpp-corbaserver} $out/bin/hppcorbaserver \
          --set HPP_PLUGIN_DIRS ${lib.makeLibraryPath plugins}
      '';

    meta = {
      description = "Corba server for Humanoid Path Planner applications";
      homepage = "https://github.com/humanoid-path-planner/hpp-corbaserver";
      license = lib.licenses.bsd2;
      maintainers = [ lib.maintainers.nim65s ];
      mainProgram = "hppcorbaserver";
      platforms = lib.platforms.unix;
    };
  });
in
hpp-corbaserver
