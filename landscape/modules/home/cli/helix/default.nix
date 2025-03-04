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
        theme = "muteoki";

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

        # Yazelix setup WIP
        keys.normal.space = {
          # ret = "@:insert-output nu ~/.config/helix/yazi.nu start <C-r>%<ret>\"\"d:open <C-r>\"<ret>";
        };

        # Lazygit integration
        keys.normal.space.space = {
          g = ":sh zellij run -i -c -n lazygit -- lazygit";
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
        muteoki = {
          "inherits" = "base16_transparent";
          palette = {
            # Normal colors
            black = "0x09090a";
            red = "0x97484f";
            green = "0x73794f";
            yellow = "0xa17a2c";
            blue = "0x4c7288";
            magenta = "0xa16a8d";
            cyan = "0x407467";
            # gray = "0xbdb193";
            gray = "0x1c1b1a";
            light-red = "0xd16469";
            light-green = "0xa6ae5a";
            light-yellow = "0xdbb560";
            light-blue = "0x77afca";
            light-magenta = "0xc193b0";
            light-cyan = "0x72afa0";
            white = "0xebe0bc";
          };
        };
      };
    };
  };
}
