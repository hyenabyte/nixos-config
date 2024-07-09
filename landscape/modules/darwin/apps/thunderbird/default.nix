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
    ${namespace}.home.programs.thunderbird = {
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
