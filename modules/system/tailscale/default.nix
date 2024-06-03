{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.tailscale;
in {
  options.tailscale = {enable = mkEnableOption "tailscale";};
  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
    };
  };
}
