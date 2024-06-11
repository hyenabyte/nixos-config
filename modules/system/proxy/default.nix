{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.proxy;
in {
  options.modules.proxy = {enable = mkEnableOption "proxy";};
  config = mkIf cfg.enable {
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
