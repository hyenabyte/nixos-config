{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.gtk;
in
{
  options.${namespace}.desktop.addons.gtk = with types; {
    enable = mkBoolOpt false "Whether to customize GTK and apply themes.";
    theme = {
      enable = mkBoolOpt true "Use a custom GTK theme";
      name = mkOpt str "Colloid-Dark-Everforest" "The name of the GTK theme to apply.";
      pkg = mkOpt package pkgs.hyenabyte.colloid-gtk-theme "The package to use for the theme.";
    };
    cursor = {
      enable = mkBoolOpt true "Use a custom cursor theme";
      name = mkOpt str "Colloid-cursors" "The name of the cursor theme to apply.";
      pkg = mkOpt package pkgs.hyenabyte.colloid-cursor-theme "The package to use for the cursor theme.";
    };
    icon = {
      enable = mkBoolOpt true "Use a custom icon theme";
      name = mkOpt str "Colloid-Everforest-Dark" "The name of the icon theme to apply.";
      pkg = mkOpt package pkgs.hyenabyte.colloid-icon-theme "The package to use for the icon theme.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.icon.pkg
      cfg.cursor.pkg
    ];

    # environment.sessionVariables = mkIf cfg.cursor.enable {
    #   XCURSOR_THEME = cfg.cursor.name;
    # };

    # hyenabyte.home.extraOptions = {
    #   gtk = {
    #     enable = true;

    #     theme = mkIf cfg.theme.enable {
    #       name = cfg.theme.name;
    #       package = cfg.theme.pkg;
    #     };

    #     cursorTheme = mkIf cfg.cursor.enable {
    #       name = cfg.cursor.name;
    #       package = cfg.cursor.pkg;
    #     };

    #     iconTheme = mkIf cfg.icon.enable {
    #       name = cfg.icon.name;
    #       package = cfg.icon.pkg;
    #     };
    #   };
    # };

    # NOTE: In order to set the cursor theme in GDM we have to specify it in the
    # dconf profile. However, the NixOS module doesn't provide an easy way to do this so the relevant
    # parts have been extracted from:
    # https://github.com/NixOS/nixpkgs/blob/96e18717904dfedcd884541e5a92bf9ff632cf39/nixos/modules/services/x11/display-managers/gdm.nix
    #
    # NOTE: The GTK and icon themes don't seem to affect recent GDM versions. I've
    # left them here as reference for the future.

    # NOTE: This no longer works at all. Newer versions o fdconf no longer include theshare/dconf/profile/gdm file
    # which is required for applying these features.
    # programs.dconf.profiles = mkIf gdmCfg.enable {
    #   gdm = let
    #     customDconf = pkgs.writeTextFile {
    #       name = "gdm-dconf";
    #       destination = "/dconf/gdm-custom";
    #       text = ''
    #         ${optionalString (!gdmCfg.autoSuspend) ''
    #           [org/gnome/settings-daemon/plugins/power]
    #           sleep-inactive-ac-type='nothing'
    #           sleep-inactive-battery-type='nothing'
    #           sleep-inactive-ac-timeout=0
    #           sleep-inactive-battery-timeout=0
    #         ''}
    #
    #         [org/gnome/desktop/interface]
    #         gtk-theme='${cfg.theme.name}'
    #         cursor-theme='${cfg.cursor.name}'
    #         icon-theme='${cfg.icon.name}'
    #       '';
    #     };
    #
    #     customDconfDb = pkgs.stdenv.mkDerivation {
    #       name = "gdm-dconf-db";
    #       buildCommand = ''
    #         ${pkgs.dconf}/bin/dconf compile $out ${customDconf}/dconf
    #       '';
    #     };
    #   in
    #     mkForce (
    #       pkgs.stdenv.mkDerivation {
    #         name = "dconf-gdm-profile";
    #         buildCommand = ''
    #           # Check that the GDM profile starts with what we expect.
    #           if [ $(head -n 1 ${pkgs.gnome.gdm}/share/dconf/profile/gdm) != "user-db:user" ]; then
    #             echo "GDM dconf profile changed, please update gtk/default.nix"
    #             exit 1
    #           fi
    #           # Insert our custom DB behind it.
    #           sed '2ifile-db:${customDconfDb}' ${pkgs.gnome.gdm}/share/dconf/profile/gdm > $out
    #         '';
    #       }
    #     );
    # };
  };
}
