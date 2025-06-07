{ lib
, config
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli.clipse;
in
{
  options.${namespace}.cli.clipse = with types; {
    enable = mkEnableOption "clipse";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];
    services.clipse = {
      enable = true;
    };
  };
}
