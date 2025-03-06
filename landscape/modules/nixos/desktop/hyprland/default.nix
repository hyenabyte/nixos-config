{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.hyprland;
in
{
  options.${namespace}.desktop.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    hyenabyte.system.xkb.enable = true;
    hyenabyte.desktop.addons = {
      wallpapers = enabled;
      gtk = enabled;
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
      };
      waybar = enabled;
      hypridle = enabled;
      hyprlock = enabled;
      dunst = enabled;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs.hyprland.enable = true;

    hyenabyte.home = {
      extraOptions = {
        wayland.windowManager.hyprland = {
          enable = true;

          settings =
            let
              terminal = "ghostty";
              fileManager = "nautilus";
              menu = "rofi -show drun";
              lock = "hyprlock";

              mainMod = "SUPER";
            in
            {
              # Monitor setup
              monitor = [
                "desc:LG Electronics LG ULTRAGEAR 209MAQQFWE16, preferred, 0x0, 1"
                "desc:AOC Q27P1B GNXJCHA039883, preferred, 2560x-550, 1, transform, 1"
                "WAYLAND-1, disable"
              ];

              env = [
                "XCURSOR_SIZE,24"
                "HYPRCURSOR_SIZE,24"
              ];

              exec-once = [
                "waybar"
                "hypridle"
                "dunst"
              ];

              general = {
                layout = "dwindle";

                gaps_in = 5;
                gaps_out = 10;

                border_size = 1;

                "col.active_border" = "0xff77afca";
                "col.inactive_border" = "0xaa595959";

                resize_on_border = false;
                allow_tearing = false;
              };

              decoration = {
                rounding = 5;

                active_opacity = 1.0;
                inactive_opacity = 1.0;

                shadow = {
                  enabled = true;
                  range = 4;
                  render_power = 3;
                  color = "0xee1a1a1a";
                };

                blur = {
                  enabled = false;
                  size = 3;
                  passes = 1;
                  vibrancy = 0.1696;
                };
              };

              animations = {
                enabled = true;

                bezier = [
                  "easeOutQuint,0.23,1,0.32,1"
                  "easeInOutCubic,0.65,0.05,0.36,1"
                  "linear,0,0,1,1"
                  "almostLinear,0.5,0.5,0.75,1.0"
                  "quick,0.15,0,0.1,1"
                ];

                animation = [
                  "global, 1, 10, default"
                  "border, 1, 5.39, easeOutQuint"
                  "windows, 1, 4.79, easeOutQuint"
                  "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                  "windowsOut, 1, 1.49, linear, popin 87%"
                  "fadeIn, 1, 1.73, almostLinear"
                  "animation = fadeOut, 1, 1.46, almostLinear"
                  "fade, 1, 3.03, quick"
                  "layers, 1, 3.81, easeOutQuint"
                  "layersIn, 1, 4, easeOutQuint, fade"
                  "layersOut, 1, 1.5, linear, fade"
                  "fadeLayersIn, 1, 1.79, almostLinear"
                  "fadeLayersOut, 1, 1.39, almostLinear"
                  "workspaces, 1, 1.94, almostLinear, fade"
                  "workspacesIn, 1, 1.21, almostLinear, fade"
                  "workspacesOut, 1, 1.94, almostLinear, fade"
                ];
              };

              dwindle = {
                pseudotile = true;
                preserve_split = true;
              };

              master = {
                new_status = "master";
              };

              misc = {
                force_default_wallpaper = -1;
                disable_hyprland_logo = false;
              };

              input = {
                kb_layout = "dk";
                kb_variant = "";
                kb_model = "";
                kb_options = "";
                kb_rules = "";

                follow_mouse = 1;
                sensitivity = 0;

                touchpad = {
                  natural_scroll = true;
                };
              };


              bind = [
                # General bindings
                "${mainMod}, T, exec, ${terminal}"
                "${mainMod}, Return, exec, ${terminal}"
                "${mainMod}, Q, killactive,"
                "${mainMod}, Q, SHIFT, exec, ${lock}"
                "${mainMod}, M, exit,"
                "${mainMod}, F, exec, ${fileManager}"
                "${mainMod}, V, togglefloating,"
                "${mainMod}, D, exec, ${menu}"
                "${mainMod}, P, pseudo,"
                "${mainMod}, B, toggleSplit,"

                # Move focus
                "${mainMod}, left, movefocus, l"
                "${mainMod}, H, movefocus, l"
                "${mainMod}, right, movefocus, r"
                "${mainMod}, L, movefocus, r"
                "${mainMod}, up, movefocus, u"
                "${mainMod}, K, movefocus, u"
                "${mainMod}, down, movefocus, d"
                "${mainMod}, J, movefocus, d"

                # Move window
                "${mainMod} SHIFT, left, movewindow, l"
                "${mainMod} SHIFT, H, movewindow, l"
                "${mainMod} SHIFT, right, movewindow, r"
                "${mainMod} SHIFT, L, movewindow, r"
                "${mainMod} SHIFT, up, movewindow, u"
                "${mainMod} SHIFT, K, movewindow, u"
                "${mainMod} SHIFT, down, movewindow, d"
                "${mainMod} SHIFT, J, movewindow, d"

                # Example special workspace (scratchpad)
                "${mainMod}, S, togglespecialworkspace, magic"
                "${mainMod} SHIFT, S, movetoworkspace, special:magic"


                # Scroll through workspaces
                "${mainMod}, mouse_down, workspace, e+1"
                "${mainMod}, mouse_up, workspace, e-1"
              ] ++ (
                # workspaces
                # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
                builtins.concatLists (builtins.genList
                  (i:
                    let ws = i + 1;
                    in [
                      "${mainMod}, code:1${toString i}, workspace, ${toString ws}"
                      "${mainMod} SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                    ]
                  )
                  9)
              );

              bindm = [
                "${mainMod}, mouse:272, movewindow"
                "${mainMod}, mouse:273, resizeWindow"
              ];

              windowrulev2 = [
                "suppressevent maximize, class:.*"
                "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
              ];
            };
        };
      };
    };

  };
}
