{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.lsd;
in {
  options.modules.lsd = {enable = mkEnableOption "lsd";};
  config = mkIf cfg.enable {
    programs.lsd = {
      enable = true;
      enableAliases = true;
    };
  };
}
