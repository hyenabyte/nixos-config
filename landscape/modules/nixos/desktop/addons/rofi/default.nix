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
    enable = mkBoolOpt false "Rofi";
    package = mkOpt package pkgs.rofi "The package to use for rofi";
  };

  config = mkIf cfg.enable {
    hyenabyte.home.programs.rofi = {
      enable = true;
      package = cfg.package;

      # font = "Atkinson Hyperlegible 14";
      location = "center";

      terminal = "${pkgs.ghostty}/bin/ghostty";
      # theme = "${cfg.package}/share/rofi/themes/gruvbox-dark-soft";
    };
  };
}
