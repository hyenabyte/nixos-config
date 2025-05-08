{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.gnome;
  defaultExtensions = with pkgs.gnomeExtensions; [
    appindicator
    just-perfection
    caffeine
    tiling-shell
  ];
in
{
  options.${namespace}.desktop.gnome = with types; {
    enable = mkEnableOption "Enable the Gnome Desktop Environment";
    monitors = mkOpt (nullOr path) null "The monitors.xml file to create.";
    extensions = mkOpt (listOf package) [ ] "Extra Gnome extensions to install.";
    # wallpaper = {
    #   light = mkOpt (oneOf [
    #     str
    #     package
    #   ]) pkgs.plusultra.wallpapers.nord-rainbow-light-nix "The light wallpaper to use.";
    #   dark = mkOpt (oneOf [
    #     str
    #     package
    #   ]) pkgs.plusultra.wallpapers.nord-rainbow-dark-nix "The dark wallpaper to use.";
    # };
  };
  config = mkIf cfg.enable {
    hyenabyte.system.xkb.enable = true;
    hyenabyte.desktop.addons = {
      wallpapers = enabled;
      gtk = enabled;
    };

    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      adwaita-icon-theme
    ]
    ++ defaultExtensions
    ++ cfg.extensions;

    environment.gnome.excludePackages = with pkgs; [
      # gnome-photos
      gnome-tour
      cheese # webcam tool
      gnome-terminal
      epiphany # web browser
      geary # email reader
      # evince # document viewer
      totem # video player
      gnome-music # music player
    ];

    # Required for app indicators
    services.udev.packages = with pkgs; [ gnome-settings-daemon ];

    # systemd.tmpfiles.rules =
    #   [ "d ${gdmHome}/.config 0711 gdm gdm" ]
    #   ++ (
    #     # "./monitors.xml" comes from ~/.config/monitors.xml when GNOME
    #     # display information is updated.
    #     lib.optional (cfg.monitors != null) "L+ ${gdmHome}/.config/monitors.xml - - - - ${cfg.monitors}"
    #   );

    systemd.services.hyenabyte-user-icon = {
      before = [ "display-manager.service" ];
      wantedBy = [ "display-manager.service" ];

      serviceConfig = {
        Type = "simple";
        User = "root";
        Group = "root";
      };

      script = ''
        config_file=/var/lib/AccountsService/users/${config.${namespace}.user.name}
        icon_file=/run/current-system/sw/share/${namespace}-icons/user/${config.${namespace}.user.name}/${
          config.${namespace}.user.icon.fileName
        }

        if ! [ -d "$(dirname "$config_file")"]; then
          mkdir -p "$(dirname "$config_file")"
        fi

        if ! [ -f "$config_file" ]; then
          echo "[User]
          Session=gnome
          SystemAccount=false
          Icon=$icon_file" > "$config_file"
        else
          icon_config=$(sed -E -n -e "/Icon=.*/p" $config_file)

          if [[ "$icon_config" == "" ]]; then
            echo "Icon=$icon_file" >> $config_file
          else
            sed -E -i -e "s#^Icon=.*$#Icon=$icon_file#" $config_file
          fi
        fi
      '';
    };
  };
}
