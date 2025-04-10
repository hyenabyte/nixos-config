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
    command = mkOpt str "Hyprland" "The Command for greetd to default to";
    enableKwallet = mkEnableOption "Unlock kwallet on login";
  };

  config = mkIf cfg.enable {
    security.pam = {
      services.greetd = {
        enableKwallet = mkIf cfg.enableKwallet true;
      };
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            let
              mapTheme = attr: foldlAttrs (acc: name: value: acc + "${name}=${value};") "" attr;
              theme = {
                text = "cyan";
                # time = "cyan";
                container = "darkgray";
                border = "white";
                # title = "cyan";
                greet = "green";
                prompt = "gray";
                input = "white";
                # action = "cyan";
                button = "yellow";
              };
            in
            ''
              ${pkgs.greetd.tuigreet}/bin/tuigreet \
                --theme '${mapTheme theme}' \
                --width 60 --window-padding 1 --container-padding 2 --prompt-padding 0 \
                --time --remember \
                --greeting 'welcome' \
                --cmd '${cfg.command}'
            '';

          user = "greeter";
        };
      };
    };

  };
}
