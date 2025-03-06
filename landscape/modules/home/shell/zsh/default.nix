{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.shell.zsh;
  enabledWithZsh = enabled // {
    enableZshIntegration = true;
  };

  plugins = [
    {
      name = "fzf-tab";
      src = pkgs.zsh-fzf-tab.src;
    }

  ];
in
{
  options.${namespace}.shell.zsh = { enable = mkEnableOption "Enable the ZSH shell"; };
  config = mkIf cfg.enable {
    hyenabyte.shell.addons = {
      bat = enabledWithZsh;
      fzf = enabledWithZsh;
      lsd = enabled // {
        enableAliases = true;
      };
      starship = enabled;
      zoxide = enabledWithZsh // {
        enableCdAlias = true;
        enableZshIntegration = true;
      };
    };

    programs.zsh = {
      enable = true;

      inherit plugins;

      # Automatically enter into a directory if typed directly into shell
      autocd = true;

      # An attribute set that adds to named directory hash table
      dirHashes = {
        nix = "$HOME/workspace/nixos-config";
        work = "$HOME/workspace";
        dl = "$HOME/Downloads";
        docs = "$HOME/Documents";
      };

      # directory to put config files in
      dotDir = ".config/zsh";

      # Enable zsh completion
      enableCompletion = true;

      # Options related to commands history configuration
      history = {
        save = 4096;
        size = 4096;
        path = "$HOME/.cache/zsh_history";
      };

      # Extra commands that should be added to .zshrc
      initExtra = ''
        if [ $(uname) = "Darwin" ]; then
          path=("$HOME/.nix-profile/bin" "/run/wrappers/bin" "/etc/profiles/per-user/$USER/bin" "/nix/var/nix/profiles/default/bin" "/run/current-system/sw/bin" "/opt/homebrew/bin" $path)
          eval "''$(/opt/homebrew/bin/brew shellenv)"
        fi

        # Keybinds
        bindkey '^ ' autosuggest-accept

        # Completion styles
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
      '';

      # Set some aliases
      shellAliases = {
        ".." = "cd ..";
        "lg" = "lazygit";
        "zed" = "zeditor";
      };

      autosuggestion = {
        enable = true;
        strategy = [
          "history"
          "completion"
        ];
      };

      syntaxHighlighting = enabled;
    };
  };
}
