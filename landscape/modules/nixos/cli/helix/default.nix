{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.helix;
in {
  options.${namespace}.cli.helix = {
    enable = mkEnableOption "Enable Helix";
    defaultEditor = mkBoolOpt false "Set Helix as default editor ($EDITOR)";
  };
  config = mkIf cfg.enable {
    home.programs.helix = {
      enable = true;
      defaultEditor = defaultEditor;

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
