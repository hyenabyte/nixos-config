{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.hyprpaper;
  # inherit (pkgs."${namespace}") wallpapers;

  wallpapers = pkgs."${namespace}".wallpapers;

in
{
  options.${namespace}.desktop.addons.hyprpaper = with types; {
    enable = mkEnableOption "Hyprpaper";
    wallpaper = mkOpt str "nix-logo-everforest.png" "The wallpaper from the wallpaper package to use";
  };

  config = mkIf cfg.enable {
    hyenabyte.home.services.hyprpaper = {
      enable = true;

      settings =
        let
          wallpaper = "${wallpapers}/share/wallpapers/${wallpaper}";
        in
        {
          ipc = true;
          splash = false;
          preload = [ "${wallpaper}" ];
          wallpaper = [
            ",${wallpaper}"
          ];
        };
    };
  };
}
