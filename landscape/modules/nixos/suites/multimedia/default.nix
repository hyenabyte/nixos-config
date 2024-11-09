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
  cfg = config.${namespace}.suites.multimedia;
in {
  options.${namespace}.suites.multimedia = with types; {
    enable =
      mkEnableOption "Enable Multimedia Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # spotify
      vlc
      youtube-music
    ];

    ${namespace} = {
      apps = {
      };
    };
  };
}
