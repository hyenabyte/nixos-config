{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.dunst;
in
{
  options.${namespace}.desktop.addons.dunst = with types; {
    enable = mkEnableOption "Dunst";
  };

  config = mkIf cfg.enable {
    hyenabyte.home.services.dunst = {
      enable = true;

      # configFile = "";
      settings = {
        global = {
          monitor = 0;
          follow = "mouse";
          enable_posix_regex = true;


          # Geometry

          width = 300;
          # height = 300;
          offset = "20x20";
          origin = "top-right";
          scale = 0;
          notification_limit = 20;
          corner_radius = 10;


          # Progress Bar

          progress_bar = true;
          progress_bar_height = 10;
          progress_bar_frame_width = 0;
          progress_bar_min_width = 125;
          progress_bar_max_width = 250;
          progress_bar_corner_radius = 4;
          icon_corner_radius = 10;
          indicate_hidden = "yes";
          transparency = 0;
          separator_height = 2;
          padding = 8;
          horizontal_padding = 8;
          text_icon_padding = 10;
          frame_width = 5;
          # frame_color = "#09090a";
          gap_size = 5;
          separator_color = "auto";
          sort = "yes";
          # idle_threshold = 120;


          # Text

          font = "Agave Nerd Font Mono 12";
          line_height = 3;
          markup = "full";
          format = "%s\n%b";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = 60;
          ellipsize = "middle";
          ignore_newline = "no";
          stack_duplicates = true;
          hide_duplicate_count = false;
          show_indicators = "yes";


          # Icons

          enable_recursive_icon_lookup = true;
          # icon_theme = "";
          icon_position = "left";
          min_icon_size = 64;
          max_icon_size = 128;


          # History

          sticky_history = "yes";
          history_length = 20;
        };
        urgency_critical = {
          background = "#f5e0dc";
          foreground = "#1e1e2e";
          frame_color = "#f38ba8";
          timeout = 0;
        };

        urgency_low = {
          background = "#6592A380";
          foreground = "#CCF1FFE6";
          frame_color = "#6592A303";
          timeout = 5;
        };

        urgency_normal = {
          background = "#09090a";
          foreground = "#ebe0bc";
          frame_color = "#3A4A6B03";
          timeout = 5;
        };
      };
    };
  };
}
