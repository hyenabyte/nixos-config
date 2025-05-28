{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli.gitui;
in
{
  options.${namespace}.cli.gitui = with types; {
    enable = mkEnableOption "gitui";
  };

  config = mkIf cfg.enable {
    programs.gitui = {
      enable = true;

      # Vim-like keybinds
      keyConfig = ''
        move_left: Some(( code: Char('h'), modifiers: "")),
        move_right: Some(( code: Char('l'), modifiers: "")),
        move_up: Some(( code: Char('k'), modifiers: "")),
        move_down: Some(( code: Char('j'), modifiers: "")),

        stash_open: Some(( code: Char('l'), modifiers: "")),
        open_help: Some(( code: F(1), modifiers: "")),

        status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),
      '';
    };
  };
}
