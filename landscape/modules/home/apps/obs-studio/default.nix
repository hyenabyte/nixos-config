{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.obs-studio;
in
{
  options.${namespace}.apps.obs-studio = { enable = mkEnableOption "Enable OBS Studio"; };
  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-tuna
      ];
    };
  };
}
