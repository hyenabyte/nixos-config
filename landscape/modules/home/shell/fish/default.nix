{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.shell.fish;
in
{
  options.${namespace}.shell.fish = { enable = mkEnableOption "Fish shell"; };
  config = mkIf cfg.enable {

    ${namespace}.shell.addons = {
      # bat = enabledWithZsh;
      # fzf = enabledWithZsh;
      # lsd = enabled // {
      #   enableAliases = true;
      # };
      # starship = enabled;
      # zoxide = enabledWithZsh // {
      #   enableCdAlias = true;
      # };
    };

    programs.fish = {
      enable = true;


    };
  };
}
