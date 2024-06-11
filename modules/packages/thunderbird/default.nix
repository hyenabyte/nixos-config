{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.thunderbird;
in {
  options.modules.thunderbird = {enable = mkEnableOption "thunderbird";};
  config = mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;
      profiles.hyena = {
        name = "hyena";
        isDeafult = true;
        settings = {};

        extraConfig = "";
        userChrome = "";
        userContent = "";
      };
    };
  };
}
