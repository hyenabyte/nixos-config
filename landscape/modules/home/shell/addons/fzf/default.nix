{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.shell.addons.fzf;
in
{
  options.${namespace}.shell.addons.fzf = with types; {
    enable = mkEnableOption "fzf";
    enableZshIntegration = mkBoolOpt false "Enable ZSH Integration";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = cfg.enableZshIntegration;
    };
  };
}
