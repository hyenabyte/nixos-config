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
    bars = mkOpt attrs
      {
        primary = {
          output = "HDMI-A-2";

          layer = "bottom";
          position = "top";

          spacing = 10;
          height = 32;
          margin-top = 10;
          margin-right = 10;
          margin-left = 10;
          margin-bottom = 0;

          modules-left = [
            "hyprland/workspaces"
            "hyprland/submap"
            "hyprland/window"
          ];

          modules-center = [
          ];

          modules-right = [
            "privacy"
            "group/group-tray"
            "group/group-hardware"
            "clock"
            "group/group-power"
          ];
        };
      } "The bars";
    extraModules = mkOpt attrs { } "Extra modules to include";
  };

  config =
    let
      terminal = "alacritty";
      runInTerm = application: "${terminal} --class=com.${namespace}.${application} -e ${application}";
    in
    mkIf cfg.enable {
      environment.defaultPackages = with pkgs; [
        lm_sensors
        bluetui
        impala
        wiremix
      ];

      ${namespace}.home.programs.waybar = {
        enable = true;

        style = builtins.readFile ./style.css;

        settings =
          let
            modules = cfg.extraModules // {
              # Hyprland
              "hyprland/workspaces" = {
                format = "{icon}";
                format-icons = {
                  active = "󱓼";
                  default = "󱓻";
                  urgent = "󱨇";
                };
                on-scroll-up = "hyprctl dispatch workspace e+1";
                on-scroll-down = "hyprctl dispatch workspace e-1";
                persistent-workspaces = {
                  "1" = [ ];
                  "2" = [ ];
                  "3" = [ ];
                  "4" = [ ];
                  "5" = [ ];
                };
              };

              "hyprland/submap" = {
                format = "[{}]";
                "max-length" = 30;
                tooltip = false;
              };

              "hyprland/window" = {
                format = "{title}";
                on-click = "rofi -show window";
                on-click-right = "hyprctl dispatch killactive";
              };

              # Tray
              tray = {
                icons-size = 18;
                spacing = 10;
              };

              idle_inhibitor = {
                format = "{icon}";
                format-icons = {
                  activated = "󰈈";
                  deactivated = "󰈉";
                };
              };

              network = {
                format = "{ifname}";
                format-disconnected = "󰤮";
                format-ethernet = "󰈀";
                format-wifi = "{icon}";
                format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
                on-click = runInTerm "impala";
                on-click-right = runInTerm "impala";
                max-length = 50;
                tooltip-format = "{ifname} via {gwaddr} 󰈀";
                tooltip-format-disconnected = "Disconnected";
                tooltip-format-ethernet = "{ifname} 󰈀";
                tooltip-format-wifi = "{essid} ({signalStrength}%) {icon}";
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

              pulseaudio = {
                format = "{volume}% {format_source}";
                format-muted = " {format_source}";
                format-bluetooth = "{volume}% {format_source}";
                format-bluetooth-muted = " {format_source}";
                format-source = "{volume}% 󰍬";
                format-source-muted = "󰍭";
                on-click = "pavucontrol";
              };

              wireplumber = {
                format = "{icon}";
                format-muted = "";
                format-icons = [ "" "" "" ];
                scroll-step = 5.0;
                tooltip = true;
                tooltip-format = "{volume}% ({node_name})";
                on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                on-click-right = runInTerm "wiremix";
              };

              bluetooth = {
                format = "󰂯";
                format-disabled = "";
                format-off = "󰂲";
                format-connected = "󰂱";
                on-click = runInTerm "bluetui";
                on-click-right = runInTerm "bluetui";
                tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
                tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
                tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
                tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
              };

              "group/group-tray" = {
                orientation = "inherit";
                modules = [
                  "tray"
                  "idle_inhibitor"
                  "network"
                  "bluetooth"
                  "wireplumber"
                ];
              };

              # Hardware diagnostics
              memory = {
                interval = 15;
                format = "RAM {percentage}%";
                max-length = 10;
                tooltip-format = "{used:0.1f}G/{total:0.1f}G";
              };

              "temperature#cpu" = {
                tooltip = false;
                hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon3/temp1_input";
                format = "CPU {temperatureC}°C";
              };

              # TODO: GPU sensor
              # "temperature#gpu" = {
              #   tooltip = false;
              #   hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon3/temp1_input";
              #   format = "GPU {temperatureC}°C";
              # };

              # Credit: https://github.com/accmeboot/dotfiles/blob/main/modules/home-manager/waybar/default.nix
              "custom/cpu" = {
                format = "CPU: {text}°C";
                exec = ''
                  temp=$(sensors | grep 'Tctl:' | awk '{print int($2)}' | sed 's/[^0-9.]*//g')
                  if [ "$temp" -lt 50 ]; then
                    class="normal"
                  elif [ "$temp" -lt 65 ]; then
                    class="medium" 
                  else
                    class="high"
                  fi
                  echo "{\"text\":\"$temp\",\"class\":\"$class\"}"
                '';
                return-type = "json";
                interval = 1;
                cursor = 68;
                tooltip = false;
              };

              "custom/gpu" = {
                format = "GPU: {text}°C";
                # TODO: missing GPU sensor
                exec = ''
                  temp=$(sensors | awk '/edge/ {if (!found) {print int($2); found=1}}')
                  if [ "$temp" -lt 50 ]; then
                    class="normal"
                  elif [ "$temp" -lt 65 ]; then
                    class="medium"
                  else
                    class="high" 
                  fi
                  echo "{\"text\":\"$temp\",\"class\":\"$class\"}"
                '';
                return-type = "json";
                interval = 1;
                cursor = 68;
                tooltip = false;
              };

              "custom/ram" = {
                format = "RAM: {text}%";
                exec = ''
                  usage=$(free -m | awk '/^Mem:/ {printf "%d", $3/$2 * 100}')
                  if [ "$usage" -lt 50 ]; then
                    class="normal"
                  elif [ "$usage" -lt 75 ]; then
                    class="medium"
                  else
                    class="high"
                  fi
                  echo "{\"text\":\"$usage\",\"class\":\"$class\"}"
                '';
                return-type = "json";
                interval = 1;
                cursor = 68;
                tooltip = false;
              };


              "group/group-hardware" = {
                orientation = "inherit";
                modules = [
                  "custom/cpu"
                  # "custom/gpu"
                  "custom/ram"
                  # "temperature#cpu"
                  # "temperature#gpu"
                  # "memory"
                ];
              };

              # Clock
              clock = {
                format = "{:%H:%M}";
                format-alt = "{:%A, %B %d, %Y (%R)}";
                tooltip = true;
                tooltip-format = "{:%A, %B %d, %Y (%R)}";
              };

              # Power group
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
                on-click = "hyprctl dispatch exit";
                tooltip-format = "Log out";
              };

              # TODO: 󰒲 suspend option

              "custom/lock" = {
                format = "󰍁";
                on-click = "hyprlock";
                tooltip-format = "Lock";
              };

              "custom/reboot" = {
                format = "󰑙";
                on-click = "reboot";
                tooltip-format = "Reboot";
              };

              "custom/power" = {
                format = "󰐥";
                on-click = "shutdown now";
                tooltip-format = "Shut down";
              };
            };
          in
          lib.attrsets.concatMapAttrs
            (name: value: {
              # Map bars to include modules
              ${name} = modules // value;
            })
            cfg.bars;
      };
    };
}
