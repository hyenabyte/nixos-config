{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.ssh;
in {
  options.${namespace}.tools.ssh = {
    enable = mkEnableOption "Enable SSH Config";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      extraConfig = ''
      '';
    };
  };
}
