{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.fastfetch;
in
{
  options.${namespace}.cli.fastfetch = { enable = mkEnableOption "fastfetch"; };
  config = mkIf cfg.enable {
    # Custom logo
    xdg.configFile =
      {
        "fastfetch/logo".source = ./logo;
      };

    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "~/.config/fastfetch/logo"; # Is it possible to link to the xdg config file somehow?
          padding = {
            top = 1;
            right = 6;
            left = 4;
          };
        };
        display = {
          separator = " :: ";
        };
        modules = [
          "break"
          "break"
          {
            type = "title";
            color = { };
            keyWidth = 10;
          }
          "break"
          {
            type = "os";
            key = " ";
          }
          {
            type = "kernel";
            key = " ";
          }
          # {
          #   type = "packages";
          #   # format = "{}";
          #   key = " ";
          # }
          {
            type = "shell";
            key = " ";
          }
          {
            type = "editor";
            key = "󰈚 ";
          }
          {
            type = "terminal";
            key = " ";
          }
          {
            type = "font";
            key = " ";
          }
          {
            type = "wm";
            key = " ";
          }
          {
            type = "uptime";
            key = " ";
          }
          {
            type = "datetime";
            format = "{1}-{3}-{11}";
            key = " ";
          }
          {
            type = "media";
            key = "󰝚 ";
          }
          # {
          #   type = "player";
          #   key = " ";
          # }
          "break"
          "break"
          "break"
        ];
      };
    };
  };
}
