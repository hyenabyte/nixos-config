{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.thunderbird;
in {
  options.${namespace}.apps.thunderbird = {enable = mkEnableOption "Enable Thunderbird";};
  config = mkIf cfg.enable {
    home.programs.thunderbird = {
      enable = true;
      profiles.${config.user.name} = {
        isDefault = true;
        settings = {};

        extraConfig = "";
        userChrome = "";
        userContent = "";
      };
    };
  };
}
