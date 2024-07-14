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
    programs.thunderbird = {
      enable = true;
      profiles.${config.${namespace}.user.name} = {
        isDefault = true;
        settings = {};

        extraConfig = "";
        userChrome = "";
        userContent = "";
      };
    };
  };
}
