{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.pantheon;
in
{
  options.${namespace}.desktop.pantheon = { enable = mkEnableOption "pantheon"; };
  config = mkIf cfg.enable {
    services.xserver.enable = true;

    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.pantheon.enable = true;

    programs.pantheon-tweaks.enable = true;

    # Disable apps in Pantheon
    # environment.pantheon.excludePackages = [ pkgs.pantheon.epiphany pkgs.pantheon.elementary-mail ];
  };
}
