{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.shell.addons.zoxide;
in
{
  options.${namespace}.shell.addons.zoxide = with types; {
    enable = mkEnableOption "Zoxide";
    enableZshIntegration = mkBoolOpt false "Enable ZSH Integration";
    enableCdAlias = mkBoolOpt false "Alias cd to zoxide";
  };

  config = mkIf cfg.enable {
    # zoxide replaces cd
    programs.zoxide = {
      enable = true;
      enableZshIntegration = cfg.enableZshIntegration;

      options = mkIf cfg.enableCdAlias [ "--cmd" "cd" ];
    };
  };
}
