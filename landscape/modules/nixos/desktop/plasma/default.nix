{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.plasma;
in
{
  options.${namespace}.desktop.plasma = { enable = mkEnableOption "plasma"; };
  config = mkIf cfg.enable {
    services.xserver.enable = true;

    hyenabyte.desktop.addons = {
      wallpapers = enabled;
      gtk = enabled;
    };

    services.desktopManager.plasma6.enable = true;
    programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
  };
}
