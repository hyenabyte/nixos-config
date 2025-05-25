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

      location = "center";

      terminal = "${pkgs.ghostty}/bin/ghostty";

      # theme = let inherit (config.lib.formats.rasi) mkLiteral; in {
      #   "#window" = {
      #     anchor = mkLiteral "south";
      #     location = mkLiteral "south";
      #     width = mkLiteral "100%";
      #     padding = mkLiteral "4px";
      #     children = mkLiteral [ "horibox" ];
      #   };

      #   "#horibox" = {
      #     orientation = mkLiteral "horizontal";
      #     children = mkLiteral [ "prompt" "entry" "listview" ];
      #   };

      #   "#listview" = {
      #     layout = mkLiteral "horizontal";
      #     spacing = mkLiteral "5px";
      #     lines = 100;
      #   };

      #   "#entry" = {
      #     expand = false;
      #     width = mkLiteral "10em";
      #   };

      #   "#element" = {
      #     padding = mkLiteral "0px 2px";
      #   };
      #   "#element selected" = {
      #     background-color = mkLiteral "SteelBlue";
      #   };
      # };
    };
  };
}
