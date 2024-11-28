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
      # Nix
      nixd
      nixpkgs-fmt
    ] ++ cfg.extraPackages;

    programs.helix = {
      enable = true;
      defaultEditor = cfg.defaultEditor;

      settings = {
        theme = "base16_transparent";

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
      };

      languages = {
        language = [
          {
            name = "nix";
            formatter.command = "nixpkgs-fmt";
            auto-format = true;
            language-servers = [ "nix-lsp" ];
          }
        ];
        language-server.nix-lsp = {
          command = "nixd";
        };
      };


      themes = {
        gruvbox_transparent = {
          "inherits" = "gruvbox";
          "ui.background" = { };
        };
        everforest_dark_transparent = {
          "inherits" = "everforest_dark";
          "ui.background" = { };
        };
      };
    };
  };
}
