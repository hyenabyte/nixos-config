{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.development;
in {
  options.${namespace}.suites.development = with types; {
    enable = mkEnableOption "Enable Development Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # beekeeper-studio
      # gitkraken
      # godot_4
      # insomnia
      # lapce
      # ldtk
      # vscode
      # pulsar
      zed-editor
    ];

    ${namespace} = {
      apps = {
        # vscode = enabled;
      };

      cli = {
        lazygit = enabled;
      };

      tools = {
        direnv = enabled;
      };
    };
  };
}
