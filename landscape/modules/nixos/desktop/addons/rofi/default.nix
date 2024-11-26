{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.rofi;
in
{
  options.${namespace}.desktop.addons.rofi = with types; {
    enable = mkBoolOpt false "Whether to enable Rofi in the desktop environment.";
    package = mkOpt package pkgs.rofi "The package to use for rofi";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];

    hyenabyte.home.configFile."rofi/config.rasi".source = ./config.rasi;
  };
}
