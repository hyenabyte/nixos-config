{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.zsh;
in {
  options.modules.zsh = {enable = mkEnableOption "zsh";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.zsh
    ];

    programs.zsh = {
      enable = true;

      # directory to put config files in
      dotDir = ".config/zsh";

      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;

      # .zshrc
      initExtra = ''
      '';

      # Tweak settings for history
      history = {
        save = 1000;
        size = 1000;
        path = "$HOME/.cache/zsh_history";
      };

      # Set some aliases
      shellAliases = {
        cat = "bat";

        zj = "zellij";
        zjl = "zellij list-sessions";
        zja = "zellij attach";

        c = "xsel -i";
        v = "xsel -o";
      };

      # Source all plugins, nix-style
      plugins = [
      ];
    };
  };
}
