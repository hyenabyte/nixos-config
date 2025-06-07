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
      settings =
        let
          font = "Maple Mono NF";
        in
        {
          general = {
            hide_cursor = true;
            grace = 5;
            disable_loading_bar = true;
            ignore_empty_input = true;
          };

          animations = {
            enable = true;
            bezier = "linear, 1, 1, 0, 0";
            animation = [
              "fadeIn, 1, 5, linear"
              "fadeOut, 1, 5, linear"
              "inputFieldDots, 1, 2, linear"
            ];
          };

          background = {
            blur_passes = 3;
            blur_size = 10;
            contrast = 1;
            brightness = 0.5;
            vibrancy = 0.2;
            vibrancy_darkness = 0.2;
          };

          label = [
            {
              text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
              color = "rgba(242, 243, 244, 0.75)";
              font_size = 22;
              font_family = font;
              position = "0, 300";
              halign = "center";
              valign = "center";
            }
            {
              text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
              color = "rgba(242, 243, 244, 0.75)";
              font_size = 95;
              font_family = font;
              position = "0, 200";
              halign = "center";
              valign = "center";
            }
          ];

          input-field = {
            size = "250, 60";
            outline_thickness = 2;

            dots_size = 0.2;
            dots_spacing = 0.35;
            dots_center = true;

            font_family = font;

            fade_on_empty = false;
            rounding = -1;
            placeholder_text = ''
              <span foreground="##ebe0bc">Locked</span>
            '';
            hide_input = false;
            position = "0, -200";
            halign = "center";
            valign = "center";

            fail_text = "<b>$ATTEMPTS</b>";
            fail_timeout = 2000;
            fail_transition = 300;
          };
        };
    };
  };
}
