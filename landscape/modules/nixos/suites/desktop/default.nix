{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.desktop;
in {
  options.${namespace}.suites.desktop = with types; {
    enable = mkEnableOption "Enable Desktop Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bitwarden
      # deluge
      # floorp
      # gnome.gnome-boxes
      protonvpn-gui
      veracrypt
      # vivaldi
      # rpi-imager
      # livecaptions
    ];

    ${namespace} = {
      desktop.plasma = enabled;
      apps = {
        alacritty = enabled;
        firefox = enabled;
        # nextcloud-client = enabled;
      };

      hardware = {
        audio.pipewire = enabled;
      };
    };
  };
}
