{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = with types; {
    enable = mkEnableOption "Enable Desktop Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bitwarden
      # deluge
      # floorp
      protonvpn-gui
      veracrypt
      # rpi-imager
      # livecaptions
    ];

    ${namespace} = {
      # desktop.plasma = enabled;
      desktop.gnome = enabled;

      hardware = {
        audio.pipewire = enabled;
      };
    };
  };
}
