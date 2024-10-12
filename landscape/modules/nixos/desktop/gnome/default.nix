{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.gnome;
in {
  options.${namespace}.desktop.gnome = {enable = mkEnableOption "gnome";};
  config = mkIf cfg.enable {
    services.xserver.enable = true;

    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      adwaita-icon-theme
    ];

    environment.gnome.excludePackages = with pkgs; [
      # gnome-photos
      gnome-tour
      cheese # webcam tool
      gnome-terminal
      epiphany # web browser
      geary # email reader
      evince # document viewer
      totem # video player
      gnome-music # music player
    ];
  };
}
