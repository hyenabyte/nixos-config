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
  options.${namespace}.desktop.hyprland = with types;{
    enable = mkEnableOption "hyprland";
    monitor = mkOpt (listOf str) [ ] "The monitor setup for hyprland";
  };
  config = mkIf cfg.enable {
    hyenabyte.system.xkb.enable = true;
    hyenabyte.desktop.addons = {
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
      };
      waybar = enabled;
      hypridle = enabled;
      hyprlock = enabled;
      hyprpaper = enabled;
      hyprsunset = enabled;
      hyprpolkitagent = enabled;
      nautilus = enabled;
      swaync = enabled;
      udiskie = enabled;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.defaultPackages = with pkgs; [
      # Hyprland specific
      hyprpicker
      hyprshot

      # Images
      feh

      # Screenshot
      grim
      slurp

      # Audio
      pavucontrol
      wiremix

      # Wifi
      impala

      # BLuetooth
      bluetui

      # Utility
      lm_sensors
    ];

    programs.hyprland.enable = true;

    hyenabyte.home = {
      # Hyprland settings
      extraOptions = {
        wayland.windowManager.hyprland = {
          enable = true;

          xwayland.enable = true;

          settings =
            let
              terminal = "${pkgs.ghostty}/bin/ghostty";
              zellij = "${terminal} --class=com.${namespace}.zellij -e zellij -l welcome";
              fileManager = "${terminal} --class=com.${namespace}.yazi -e yazi";
              fileManager-gui = "nautilus";
              browser = "zen-beta";
              clipse = "${terminal} --class=com.${namespace}.clipse -e clipse";
              wiremix = "${terminal} --class=com.${namespace}.wiremix -e wiremix";
              bluetui = "${terminal} --class=com.${namespace}.bluetui -e bluetui";
              launcher = "rofi -show drun";
              lock = "hyprlock";
              colorPicker = "hyprpicker -a";
              screenshot = "grim -g \"$(slurp)\"";
              swaync-toggle = "swaync-client -t";
              swaync-dnd = "swaync-client -d";

              mainMod = "SUPER";

              workspaceCount = 9;
            in
            {
              # Monitor setup
              monitor = cfg.monitor ++ [
                "WAYLAND-1, disable"
              ];

              env = [
                "XCURSOR_SIZE,24"
                "HYPRCURSOR_SIZE,24"
              ];

              exec-once = [
                # Focus workspace 1 on startup
                "hyprctl dispatch workspace 1"
                # Waybar
                "killall -q waybar;sleep .5 && waybar"
                # Swaync - Notifications
                "killall -q swaync;sleep .5 && swaync"
              ];

              general = {
                layout = "dwindle";

                gaps_in = 5;
                gaps_out = 10;

                border_size = 2;

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
                blur = {
                  size = 10;
                  passes = 3;
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

                # DPMS
                mouse_move_enables_dpms = true;
                key_press_enables_dpms = true;

                # Splash
                disable_splash_rendering = true;
                splash_font_family = "Atkinson Hyperlegible";
              };

              ecosystem = {
                no_update_news = true;
                no_donation_nag = true;
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
                "${mainMod} SHIFT, Z, exit"
                "${mainMod}, X, exec, ${lock}"

                "${mainMod}, Q, killactive,"
                "${mainMod} SHIFT, Q, forcekillactive,"

                # Apps
                "${mainMod}, Space, exec, ${launcher}"
                "${mainMod}, D, exec, ${launcher}"
                "${mainMod}, E, exec, ${fileManager}"
                "${mainMod} SHIFT, E, exec, ${fileManager-gui}"
                "${mainMod}, U, exec, ${colorPicker}"
                "${mainMod}, T, exec, ${terminal}"
                "${mainMod} SHIFT, Return, exec, ${zellij}"
                "${mainMod}, Return, exec, ${terminal}"
                "${mainMod}, V, exec, ${clipse}"
                "${mainMod}, W, exec, ${browser}"
                "${mainMod}, I, exec, ${screenshot}"
                "${mainMod}, Print, exec, ${screenshot}"
                "${mainMod}, O, exec, ${wiremix}"
                "${mainMod} SHIFT, O, exec, pavucontrol"
                "${mainMod} SHIFT, B, exec, ${bluetui}"
                "${mainMod}, M, exec, ${swaync-toggle}"
                "${mainMod} SHIFT, M, exec, ${swaync-dnd}"

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

              windowrulev2 =
                let
                  floatingWindows = [
                    "clipse"
                    "wiremix"
                    "bluetui"
                    "impala"
                  ];

                  floatingWindowsMapped = builtins.concatLists (builtins.map
                    (app: [
                      "float, class:(com.${namespace}.${app})"
                      "size 750 500, class:(com.${namespace}.${app})"
                      "stayfocused, class:(com.${namespace}.${app})"
                    ])
                    floatingWindows);

                in
                [
                  "suppressevent maximize, class:.*"
                  "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

                  # Float pavucontrol
                  "float, class:^(org.pulseaudio.pavucontrol)$"
                  "size 750 500, class:^(org.pulseaudio.pavucontrol)$"

                  # Float Picture-in-Picture windows
                  "float, title:^(Picture-in-Picture)$"
                  "size 750 500, title:^(Picture-in-Picture)"

                  # Steam
                  "float, title:^(Friends List)$"
                  "size 400 750, title:^(Friends List)"

                  # Veadotube
                  "float, title:^(veadotube-mini)$"
                  "size 600 500, title:^(veadotube-mini)"

                  # Zen Extension Windows
                  "float, title:^Extension:.*, class:^(zen-beta)$"
                  "size 400 750, title:^Extension:.*, class:^(zen-beta)$"

                ] ++ floatingWindowsMapped;

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
