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
      gnome.gnome-tweaks
    ];

    environment.gnome.excludePackages =
      (with pkgs; [
        # gnome-photos
        gnome-tour
      ])
      ++ (with pkgs.gnome; [
        cheese # webcam tool
        gnome-music
        gnome-terminal
        # gedit # text editor
        epiphany # web browser
        geary # email reader
        evince # document viewer
        # gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ]);
  };
}
