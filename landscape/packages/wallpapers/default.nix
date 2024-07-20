{
  pkgs,
  lib,
  namespace,
  ...
}: let
  images = builtins.attrNames (builtins.readDir ./assets);

  mkWallpaper = name: src: let
    fileName = builtins.baseNameOf src;
    pkg = pkgs.stdenvNoCC.mkDerivation {
      inherit name src;

      dontUnpack = true;

      installPhase = ''
        cp $src $out
      '';

      passthru = {
        inherit fileName;
      };
    };
  in
    pkg;

  names = builtins.map (lib.snowfall.path.get-file-name-without-extension) images;

  wallpapers =
    lib.foldl (
      acc: image: let
        name = lib.snowfall.path.get-file-name-without-extension image;
      in
        acc // {"${name}" = mkWallpaper name (./assets + "/${image}");}
    ) {}
    images;

  installTarget = "$out/share/wallpapers";
in
  pkgs.stdenvNoCC.mkDerivation {
    name = "hyenas-wallpapers";
    src = ./assets;

    installPhase = ''
      mkdir -p ${installTarget}

      find * -type f -mindepth 0 -maxdepth 0 -exec cp ./{} ${installTarget}/{} ';'
    '';

    passthru =
      {
        inherit names;
      }
      // wallpapers;

    meta = with lib; {
      description = "Hyenas Wallpapers";
    };
  }
