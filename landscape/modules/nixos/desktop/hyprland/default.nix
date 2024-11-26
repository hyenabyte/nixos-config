{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.hyprland;
in
{
  options.${namespace}.desktop.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    hyenabyte.system.xkb.enable = true;
    hyenabyte.desktop.addons = {
      wallpapers = enabled;
      gtk = enabled;
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
      };
      waybar = enabled;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs.hyprland = {
      enable = true;

      xwayland.enable = true;
    };
  };
}
