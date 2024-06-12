{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.bat;
in {
  options.modules.bat = {enable = mkEnableOption "bat";};
  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };

    programs.zsh.shellAliases = {
      cat = "bat";
      diff = "batdiff";
      man = "batman";
      grep = "batgrep";
      watch = "batwatch";
    };
  };
}
