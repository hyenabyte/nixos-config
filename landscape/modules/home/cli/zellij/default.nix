{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.zellij;

  everforest-dark = {
    bg = "#2d353b";
    fg = "#d3c6aa";

    black = "#475258";
    red = "#e67e80";
    green = "#a7c080";
    yellow = "#dbbc7f";
    blue = "#7fbbb3";
    magenta = "#d699b6";
    cyan = "#83c092";
    white = "#d3c6aa";
    orange = "#e69875";
  };
  muteoki-dark = {
    bg = "#09090a";
    fg = "#ebe0bc";

    black = "#09090a";
    red = "#97484f";
    green = "#73794f";
    yellow = "#a17a2c";
    blue = "#4c7288";
    magenta = "#a16a8d";
    cyan = "#407467";
    white = "#bdb193";
    orange = "#966945";
  };
in
{
  options.${namespace}.cli.zellij = with types; {
    enable = mkEnableOption "zellij";
    enableZshIntegration = mkBoolOpt false "Enable ZSH Integration";
  };
  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = cfg.enableZshIntegration;

      settings = {

        ui.pane_frames.rounded_corners = true;


        # theme = "muteoki-dark";

        themes.everforest-dark = everforest-dark;
        themes.muteoki-dark = muteoki-dark;
      };
    };

    programs.zsh.shellAliases = {
      zj = "zellij";
      zjl = "zellij list-sessions";
      zja = "zellij attach";
    };
  };
}
