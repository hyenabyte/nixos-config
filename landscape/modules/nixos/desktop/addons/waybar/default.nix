{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.waybar;
in
{
  options.${namespace}.desktop.addons.waybar = with types; {
    enable = mkEnableOption "Waybar";
  };

  config = mkIf cfg.enable {
    hyenabyte.home.programs.waybar = {
      enable = true;

      style = builtins.readFile ./style.css;

      settings =
        let
          mainMonitor = "DP-2";
          secondMonitor = "HDMI-A-2";
          modules = {
            tray = {
              icons-size = 18;
              spacing = 10;
            };

            clock = {
              format = "{:%A %H:%M}";
              format-alt = "{:%B %d, %Y %R}";
            };

            pulseaudio = {
              format = "{volume}% {format_source}";
              format-muted = " {format_source}";

              format-bluetooth = "{volume}% {format_source}";
              format-bluetooth-muted = " {format_source}";

              format-source = "{volume}% ";
              format-source-muted = "";

              on-click = "pavucontrol";
            };

            cpu = {
              interval = 5;
              format = "{usage}% ";
              max-length = 10;
            };

            memory = {
              interval = 15;
              format = "{percentage}% ";
              max-length = 10;
              tooltip-format = "{used:0.1f}G/{total:0.1f}G";
            };

            "hyprland/workspaces" = {
              format = "{icon}";
              format-icons = {
                active = "";
                default = "";
              };
              persistent-workspaces = {
                DP-2 = [ 1 ];
                HDMI-A-2 = [ 2 ];
              };
            };

            idle_inhibitor = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deacrtivated = "";
              };
            };

            network = {
              interface = "wlp2s0";
              format = "{ifname}";
              format-wifi = "{essid} ({signalStrength}%) ";
              format-ethernet = "{ipaddr}/{cidr} 󰊗";
              format-disconnected = "";
              tooltip-format = "{ifname} via {gwaddr} 󰊗";
              tooltip-format-wifi = "{essid} ({signalStrength}%) ";
              tooltip-format-ethernet = "{ifname} ";
              tooltip-format-disconnected = "Disconnected";
              max-length = 50;
            };

            privacy = {
              icon-spacing = 4;
              icon-size = 18;
              transition-duration = 250;
              modules = [
                {
                  type = "screenshare";
                  tooltip = true;
                  tooltip-icon-size = 24;
                }
                {
                  type = "audio-out";
                  tooltip = true;
                  tooltip-icon-size = 24;
                }
                {
                  type = "audio-in";
                  tooltip = true;
                  tooltip-icon-size = 24;
                }
              ];
            };

            "group/group-power" = {
              orientation = "inherit";
              drawer = {
                transition-duration = 500;
                children-class = "not-power";
                transition-left-to-right = false;
              };
              modules = [
                "custom/power"
                "custom/quit"
                "custom/lock"
                "custom/reboot"
              ];
            };

            "custom/quit" = {
              format = "󰗼";
              tooltip = false;
              on-click = "hyprctl dispatch exit";
            };

            "custom/lock" = {
              format = "󰍁";
              tooltip = false;
              on-click = "hyprlock";
            };

            "custom/reboot" = {
              format = "󰜉";
              tooltip = false;
              on-click = "reboot";
            };

            "custom/power" = {
              format = "";
              tooltip = false;
              on-click = "shutdown now";
            };
          };
        in
        {
          mainBar = {
            output = mainMonitor;

            layer = "top";
            position = "top";

            modules-left = [
              "hyprland/workspaces"
              "hyrpland/submap"
              "hyprland/window"
            ];

            modules-center = [
              "clock"
            ];

            modules-right = [
              "idle_inhibitor"
              "cpu"
              "memory"
              "network"
              "privacy"
              "tray"
              "bluetooth"
              "pulseaudio"
              "group/group-power"
            ];
          } // modules;

          secondBar = {

            output = secondMonitor;

            layer = "top";
            position = "top";

            modules-left = [
              "hyprland/workspaces"
              "hyrpland/submap"
              # "hyprland/window"
            ];

            modules-center = [
            ];

            modules-right = [
            ];
          } // modules;
        };
    };
  };
}
