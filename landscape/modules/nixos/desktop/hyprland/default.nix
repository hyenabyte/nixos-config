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
      hyprpaper = enabled;
      nautilus = enabled;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.defaultPackages = with pkgs; [
      hyprpolkitagent
      hyprpicker
      hyprsunset
      wl-clipboard
      clipse
      swaynotificationcenter
      grim
      slurp
      loupe
      pavucontrol
      feh
      hyprshot
      udiskie
    ];

    programs.hyprland.enable = true;

    hyenabyte.home = {
      # Hyprland settings
      extraOptions = {
        wayland.windowManager.hyprland = {
          enable = true;

          # plugins = with pkgs.hyprlandPlugins; [
          #   hy3
          # ];

          settings =
            let
              terminal = "ghostty";
              zellij = "ghostty --class=com.${namespace}.zellij -e zellij -l welcome";
              fileManager = "ghostty --class=com.${namespace}.yazi -e yazi";
              fileManager-gui = "nautilus";
              browser = "zen";
              clipse = "ghostty --class=com.${namespace}.clipse -e clipse";
              launcher = "rofi -show drun";
              lock = "hyprlock";
              colorPicker = "hyprpicker -a";
              screenshot = "grim -g \"$(slurp)\"";

              signal = "signal-desktop --password-store=kwallet6";

              mainMod = "SUPER";

              workspaceCount = 9;
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
                # Focus workspace 1 on startup
                "hyprctl dispatch workspace 1"
                # Polkit
                "systemctl --user start hyprpolkitagent"
                # Waybar
                "killall -q waybar;sleep .5 && waybar"
                # Swaync - Notifications
                "killall -q swaync;sleep .5 && swaync"
                # Hyprsunset - red light filter
                "hyprsunset"
                # Udiskie - automount USB drives
                "udiskie"
                # Signal
                # "${signal}" # Kwallet doesnt unlock with greetd for some reason :c
              ];

              general = {
                layout = "dwindle";

                gaps_in = 5;
                gaps_out = 10;

                border_size = 2;

                "col.active_border" = "rgb(ebe0bc)";
                "col.inactive_border" = "rgba(595959aa)";

                resize_on_border = false;
                allow_tearing = false;
              };

              debug = {
                disable_logs = false;
              };

              decoration = {
                rounding = 5;

                active_opacity = 1.0;
                inactive_opacity = 1.0;

                shadow.enabled = true;
                blur.enabled = false;
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
                  "fadeOut, 1, 1.46, almostLinear"
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
                # disable_autoreload = true;
                force_default_wallpaper = 2;
                disable_hyprland_logo = true;
                font_family = "Atkinson Hyperlegible";
                animate_manual_resizes = true;
                background_color = "rgb(09090a)";

                # DPMS
                mouse_move_enables_dpms = true;
                key_press_enables_dpms = true;

                # Splash
                disable_splash_rendering = true;
                splash_font_family = "Atkinson Hyperlegible";
              };

              input = {
                kb_layout = "dk";
                kb_variant = "";
                kb_model = "";
                kb_options = "caps:escape";
                kb_rules = "";

                follow_mouse = 1;
                sensitivity = 0;

                touchpad = {
                  natural_scroll = true;
                };
              };


              bind = [
                # General bindings
                "${mainMod} SHIFT, M, exit"
                "${mainMod}, X, exec, ${lock}"

                "${mainMod}, Q, killactive,"
                # "${mainMod} SHIFT, Q, forcekillactive," # FIXME: dispather missing in current version

                # Apps
                "${mainMod}, Space, exec, ${launcher}"
                "${mainMod}, D, exec, ${launcher}"
                "${mainMod}, E, exec, ${fileManager}"
                "${mainMod} SHIFT, E, exec, ${fileManager-gui}"
                "${mainMod}, I, exec, ${colorPicker},"
                "${mainMod}, T, exec, ${terminal}"
                "${mainMod}, Return, exec, ${zellij}"
                "${mainMod} SHIFT, Return, exec, ${terminal}"
                "${mainMod}, V, exec, ${clipse}"
                "${mainMod}, W, exec, ${browser}"
                "${mainMod}, I, exec, ${screenshot}"
                "${mainMod}, Print, exec, ${screenshot}"
                "${mainMod}, O, exec, pavucontrol"


                # Misc window movement
                "${mainMod}, F, fullscreen,"
                "${mainMod} SHIFT, F, togglefloating,"
                "${mainMod}, C, centerwindow"
                "${mainMod}, P, pseudo,"
                "${mainMod}, B, toggleSplit,"
                "${mainMod} SHIFT, W, swapactiveworkspaces, DP-2 HDMI-A-2"

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
                "${mainMod}, A, togglespecialworkspace, term"
                "${mainMod} SHIFT, A, movetoworkspace, special:term"


                # Scroll through workspaces
                # "${mainMod}, mouse_down, workspace, e+1"
                # "${mainMod}, mouse_up, workspace, e-1"

              ] ++ (
                # workspaces
                # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
                builtins.concatLists (builtins.genList
                  (i:
                    let ws = i + 1;
                    in [
                      "${mainMod}, code:1${toString i}, workspace, ${toString ws}"
                      "${mainMod} SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                      "${mainMod} CTRL, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
                    ]
                  )
                  workspaceCount)
              );

              bindm = [
                "${mainMod}, mouse:272, movewindow"
                "${mainMod}, mouse:273, resizeWindow"
              ];

              bindl = [
                # Laptop multimedia keys for volume and LCD brightness
                " ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                " ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                " ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                " ,XF86MonBrightnessUp, exec, brightnessctl s 10%+"
                " ,XF86MonBrightnessDown, exec, brightnessctl s 10%-"
                # Requires playerctl
                " , XF86AudioNext, exec, playerctl next"
                " , XF86AudioPause, exec, playerctl play-pause"
                " , XF86AudioPlay, exec, playerctl play-pause"
                " , XF86AudioPrev, exec, playerctl previous"
              ];

              windowrulev2 = [
                "suppressevent maximize, class:.*"
                "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

                # Float pavucontrol
                "float, class:^(org.pulseaudio.pavucontrol)$"
                "size 750 500, class:^(org.pulseaudio.pavucontrol)$"

                # Float clipse
                "float, class:(com.${namespace}.clipse)"
                "size 750 500, class:(com.${namespace}.clipse)"
                "stayfocused, class:(com.${namespace}.clipse)"

                # Float Picture-in-Picture windows
                "float, title:^(Picture-in-Picture)$"
                "size 750 500, class:(Picture-in-Picture)"

                # Steam
                "float, title:^(Friends List)$"
                "size 400 750, class:(Friends List)"
              ];

              workspace = [
                "1, monitor:desc:LG Electronics LG ULTRAGEAR 209MAQQFWE16, default:true"
                "2, monitor:desc:AOC Q27P1B GNXJCHA039883, default:true"
              ];
            };

          extraConfig =
            let
              mainMod = "SUPER";
            in
            ''
              # Resize mode
              bind = ${mainMod}, N, submap, resize

              submap = resize

              binde = , right, resizeactive, 100 0
              binde = , left, resizeactive, -100 0
              binde = , up, resizeactive, 0 -100
              binde = , down, resizeactive, 0 100
              binde = , L, resizeactive, 100 0
              binde = , H, resizeactive, -100 0
              binde = , K, resizeactive, 0 -100
              binde = , J, resizeactive, 0 100

              # precision mode
              binde = SHIFT, right, resizeactive, 10 0
              binde = SHIFT, left, resizeactive, -10 0
              binde = SHIFT, up, resizeactive, 0 -10
              binde = SHIFT, down, resizeactive, 0 10
              binde = SHIFT, L, resizeactive, 10 0
              binde = SHIFT, H, resizeactive, -10 0
              binde = SHIFT, K, resizeactive, 0 -10
              binde = SHIFT, J, resizeactive, 0 10

              bind = , escape, submap, reset
              bind = , return, submap, reset
              bind = ${mainMod}, N, submap, reset
              submap = reset

              bind = ${mainMod}, Z, submap, power
              submap = power
              
              bind = , L, exit
              bind = , X, exec, hyprlock
              bind = , S, exec, systemctl suspend
              bind = , R, exec, systemctl reboot
              bind = , Q, exec, systemctl poweroff

              # Reset submap on suspend and lock, so it doesnt restart into power submap mode
              bind = , X, submap, reset
              bind = , S, submap, reset

              bind = , escape, submap, reset
              bind = , return, submap, reset
              bind = ${mainMod}, Z, submap, reset
              submap = reset
            '';
        };
      };
    };
  };
}
