{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.kitty;
in
{
  options.${namespace}.apps.kitty = { enable = mkEnableOption "kitty"; };
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      enableGitIntegration = true;

      shellIntegration.enableZshIntegration = true;

      settings = {
        enable_audio_bell = false;
        window_padding_width = 20;
      };

    };
  };
}
