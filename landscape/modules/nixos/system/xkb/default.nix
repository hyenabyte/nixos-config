{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.xkb;
in {
  options.${namespace}.system.xkb = {enable = mkEnableOption "xkb";};
  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver.xkb = {
      layout = "dk";
      variant = "";
      options = "caps:escape";
    };
  };
}
