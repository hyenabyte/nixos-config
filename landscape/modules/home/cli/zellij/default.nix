{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.zellij;
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

        show_startup_tips = false;
        show_release_notes = false;
      };
    };

    programs.zsh.shellAliases = mkIf cfg.enableZshIntegration {
      zj = "zellij";
      zjl = "zellij list-sessions";
      zja = "zellij attach";
    };
  };
}
