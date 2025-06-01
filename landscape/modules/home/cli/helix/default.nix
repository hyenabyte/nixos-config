{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli.helix;
in
{
  options.${namespace}.cli.helix = {
    enable = mkEnableOption "Enable Helix";
    defaultEditor = mkBoolOpt false "Set Helix as default editor ($EDITOR)";
    extraPackages = mkPackageListOption [ ] "Extra packages to install with Helix";
    evil = mkEnableOption "Enable Evil Mode (evil-helix)";
  };
  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;

      package = mkIf cfg.evil pkgs.evil-helix;

      # Install various language servers
      extraPackages = with pkgs; [
        # CSS, eslint, HTML, JSON, markdown
        vscode-langservers-extracted
        # ts, tsx
        typescript-language-server
        # Nix
        nixd
        nixpkgs-fmt
        # Nickel
        nls
      ] ++ cfg.extraPackages;

      defaultEditor = cfg.defaultEditor;

      settings = {
        theme = "everforest_dark";
        editor = {
          shell = [ "zsh" "-c" ];
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

        # Disable movement keys in insert mode
        keys.insert = {
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
          pageup = "no_op";
          pagedown = "no_op";
          home = "no_op";
          end = "no_op";
        };

        # Use Ctrl+h/j/k/l to move faster
        keys.normal = {
          "C-j" = "page_cursor_half_down";
          "C-k" = "page_cursor_half_up";
          "C-h" = "page_down";
          "C-l" = "page_up";

          "½" = "switch_to_lowercase";
          "A-½" = "switch_to_uppercase";
          "§" = "switch_case";

          # Append semicolon to end of string
          # https://github.com/helix-editor/helix/discussions/9118#discussioncomment-10127457
          "C-," = [
            "goto_line_end"
            ":append-output echo \";\""
            "collapse_selection"
            "keep_primary_selection"
          ];
        };

        # Yazelix setup WIP
        keys.normal.space = {
          # ret = "@:insert-output nu ~/.config/helix/yazi.nu start <C-r>%<ret>\"\"d:open <C-r>\"<ret>";
        };

        # Space space mode
        keys.normal.space.space = {
          g = ":sh zellij run -i -c -n lazygit -- lazygit";
          f = ":sh zellij run -i -c -n yazi -- yazi";
        };
      };

      languages = {
        language = [
          {
            name = "nix";
            formatter.command = "nixpkgs-fmt";
            auto-format = true;
            language-servers = [ "nix-lsp" ];
          }
          {
            name = "typescript";
            formatter = {
              command = "prettier";
              args = [ "--parser" "typescript" ];
            };
            file-types = [ "ts" ];
            auto-format = true;
          }
          {
            name = "tsx";
            formatter = {
              command = "prettier";
              args = [ "--parser" "typescript" ];
            };
            file-types = [ "tsx" ];
            auto-format = true;
          }
        ];
        language-server.nix-lsp = {
          command = "nixd";
        };
      };
    };
  };
}
