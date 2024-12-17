{ lib
, makeDesktopItem
, fetchurl
, fetchzip
, stdenv
, writeShellScriptBin
, namespace
, pkgs
, ...
}:
let
  with-meta = lib.${namespace}.override-meta {
    platforms = lib.platforms.linux;

    description = "Mixitup";
    maintainers = with lib.maintainers; [ ];
  };

  mixitup-src = fetchzip {
    url = "https://github.com/SaviorXTanren/mixer-mixitup/releases/download/1.2.0/MixItUp.zip";
    sha256 = "sha256-Zv7jxFKcYlQSz3Mf5fgK2REGrbslfp6wSKHBRrSd7jU=";
    stripRoot = false;
  };

  derivation = stdenv.mkDerivation {
    name = "mixitup";
    version = "1.2.0";

    src = mixitup-src;

    installPhase = ''
      mkdir -p "$out"
      cp -a "$src/." "$out/"
    '';

    enablePatchelf = false;
  };
  bin = writeShellScriptBin "mixitup" ''
    ${pkgs.wine64}/bin/wine64 ${derivation}/MixItUp.exe
  '';

  mixitup = makeDesktopItem {
    name = "mixitup";
    desktopName = "Mixitup";
    genericName = "Mixitup";
    exec = "${bin}/bin/mixitup";
    icon = fetchurl {
      url = "https://github.com/SaviorXTanren/mixer-mixitup/blob/master/Branding/Mix-It-Up_Logo-2018_Spiral-Only_Color.png?raw=true";
      sha256 = "sha256-owpCkvshA3ihWXH3qj6iISwtrUOe7dTgVdzERVnQseA=";
    };
    type = "Application";
  };
in
with-meta mixitup
