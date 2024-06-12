{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.alacritty;
in {
  options.modules.alacritty = {enable = mkEnableOption "alacritty";};
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings =
        {
          window = {
            padding.x = 20;
            padding.y = 20;
            dynamic_padding = true;
          };

          font = {
            normal.family = "Agave Nerd Font Mono";
            size = 12;
          };

          cursor.style = {
            # "Block" | "Underline" | "Beam"
            # Default: "Block"
            shape = "underline";

            # "Never" | "Off" | "On" | "Always"
            # Default: "Off"
            blinking = "Off";
          };
        }
        // builtins.fromTOML (builtins.readFile ./themes/catppuccin-mocha.toml);
    };
  };
}
