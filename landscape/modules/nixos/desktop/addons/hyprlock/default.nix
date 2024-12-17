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

        input-field = {
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = "rgb(205, 214, 244)";
          fade_on_empty = false;
          rounding = -1;
          placeholder_text = ''
            <span foreground="##cdd6f4">Password</span>
          '';
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
          check_color = "rgb(108, 112, 134)";
          fail_color = "rgb(243, 139, 168)";
          fail_text = "<b>$ATTEMPTS</b>";
          fail_timeout = 2000;
          fail_transition = 300;
        };
      };
    };
  };
}
