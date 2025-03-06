{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.dm.greetd;
in
{
  options.${namespace}.desktop.dm.greetd = with types; {
    enable = mkEnableOption "Greetd";
    command = mkOpt types.str "Hyprland" "The Command for greetd to default to";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${cfg.command}";
        };
      };
    };
  };
}
