{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.hyprlock;
in
{
  options.${namespace}.desktop.addons.hyprlock = with types; {
    enable = mkEnableOption "Hyprlock";
  };

  config = mkIf cfg.enable {
    security.pam.services.hyprlock = { };
    hyenabyte.home.programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          no_fade_in = false;
          no_fade_out = false;
          hide_cursor = true;
          grace = 0;
          disable_loading_bar = true;
          ignore_empty_input = true;
        };

        background = {
          color = "rgb(09090a)";
        };

        input-field = {
          size = "250, 60";
          outline_thickness = 2;

          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;

          outer_color = "rgba(ebe0bcff)";
          inner_color = "rgba(09090aff)";

          font_color = "rgb(ebe0bc)";
          font_family = "Atkinson Hyperlegible";

          fade_on_empty = false;
          rounding = -1;
          placeholder_text = ''
            <span foreground="##ebe0bc">Locked</span>
          '';
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
          check_color = "rgb(407467)";
          fail_color = "rgb(97484f)";
          fail_text = "<b>$ATTEMPTS</b>";
          fail_timeout = 2000;
          fail_transition = 300;
        };
      };
    };
  };
}
