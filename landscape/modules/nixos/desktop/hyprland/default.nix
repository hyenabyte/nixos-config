{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.hyprland;
in {
  options.${namespace}.desktop.hyprland = {enable = mkEnableOption "hyprland";};
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
    ];

    programs.hyprland = {
      enable = true;

      xwayland.enable = true;
    };
  };
}
