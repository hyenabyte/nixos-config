{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.helix;
in {
  options.modules.helix = {enable = mkEnableOption "helix";};
  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "catppuccin_mocha";

        editor = {
          shell = ["zsh" "-c"];
          cursorline = true;
          color-modes = true;
          auto-format = true;
          lsp.display-inlay-hints = true;

          cursor-shape = {
            insert = "bar";
            normal = "underline";
            select = "block";
          };

          file-picker.hidden = false;

          whitespace.render = {
            space = "all";
            tab = "all";
            newline = "none";
          };

          whitespace.characters = {
            space = "·";
            nbsp = "⍽";
            tab = "→";
            newline = "⏎";
            tabpad = "·";
          };
        };
      };
      languages.language = [
        {
          name = "nix";
          formatter.command = "alejandra";
          auto-format = true;
        }
      ];
      themes = {
        gruvbox_transparent = {
          "inherits" = "gruvbox";
          "ui.background" = {};
        };
        everforest_dark_transparent = {
          "inherits" = "everforest_dark";
          "ui.background" = {};
        };
      };
    };
  };
}
