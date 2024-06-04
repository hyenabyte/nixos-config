{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.cinnamon;
in {
  options.cinnamon = {enable = mkEnableOption "cinnamon";};
  config = mkIf cfg.enable {
    services.xserver.enable = true;

    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;

    # programs.cinnamon-tweaks.enable = true;

    # Disable apps in cinnamon
    # environment.cinnamon.excludePackages = [ pkgs.cinnamon.epiphany pkgs.cinnamon.elementary-mail ];
  };
}
