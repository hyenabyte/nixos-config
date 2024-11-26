{ lib
, stdenvNoCC
, fetchFromGitHub
, gitUpdater
, jdupes
}:

let
  pname = "colloid-cursor-theme";
in
stdenvNoCC.mkDerivation
rec {
  inherit pname;
  version = "2024-10-18";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "colloid-icon-theme";
    rev = version;
    hash = "sha256-xpRgOt/FqZSbtOlZKlZS1ILQn6OAwqKAXX3hj41Wo+0=";
  };

  nativeBuildInputs = [
    jdupes
  ];

  postPatch = ''
    patchShebangs ./cursors/install.sh
  '';

  installPhase = ''
    runHook preInstall

    cd ./cursors

    mkdir -p "$out/share/icons/"
    cp -r dist "$out/share/icons/Colloid-cursors"
    cp -r dist-dark "$out/share/icons/Colloid-dark-cursors"

    jdupes --quiet --link-soft --recurse $out/share

    runHook postInstall
  '';

  passthru.updateScript = gitUpdater { };

  meta = with lib; {
    description = "Colloid cursor theme";
    homepage = "https://github.com/vinceliuice/Colloid-icon-theme/tree/main/cursors";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
  };
}
