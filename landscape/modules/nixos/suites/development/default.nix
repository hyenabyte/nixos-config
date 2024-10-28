{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.development;
in
{
  options.${namespace}.suites.development = with types; {
    enable = mkEnableOption "Enable Development Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # --- Webdev ---
      beekeeper-studio
      bruno

      # --- Game dev ---
      godot_4
      # ldtk
      # trenchbroom

      # --- Common ---
      # zed-editor
      # lapce
      vscode
      # pulsar
      # vscodium

      # --- Socials ---
      slack
    ];

    ${namespace} = {
      apps = {
        # vscode = enabled;
      };

      cli = {
        lazygit = enabled;
      };

      tools = {
        #direnv = enabled;
      };
    };
  };
}
