{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.ssh;
in {
  options.ssh = {enable = mkEnableOption "ssh";};
  config = mkIf cfg.enable {
    services.openssh.enable = true;
  };
}
