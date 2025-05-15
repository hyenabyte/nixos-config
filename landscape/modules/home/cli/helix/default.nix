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
  };
  config = mkIf cfg.enable {

    # Install various language servers
    home.packages = with pkgs; [
      # CSS, eslint, HTML, JSON, markdown
      vscode-langservers-extracted
      # ts, tsx
      typescript-language-server
      # Nix
      nixd
      nixpkgs-fmt
    ] ++ cfg.extraPackages;

    programs.helix = {
      enable = true;
      defaultEditor = cfg.defaultEditor;

      settings = {
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
        };

        # Yazelix setup WIP
        keys.normal.space = {
          # ret = "@:insert-output nu ~/.config/helix/yazi.nu start <C-r>%<ret>\"\"d:open <C-r>\"<ret>";
        };

        # Lazygit integration
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
              args = [ "--stdin-filename" "file.tsx" ];
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
