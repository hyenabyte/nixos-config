{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.shell.zsh;
in {
  options.${namespace}.system.shell.zsh = {enable = mkEnableOption "shell.zsh";};
  config = mkIf cfg.enable {
    # ? Consider splitting some of these configs up into their own modules

    environment.systemPackages = with pkgs; [
      bat
      croc
      fzf
      ncdu
      xh
      xsel
      yazi
      zoxide
      starship
      zsh
    ];

    programs.zsh = enabled;

    ${namespace}.home.programs = {
      zsh = {
        enable = true;

        # directory to put config files in
        dotDir = ".config/zsh";

        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        # Antidote
        antidote = {
          enable = true;
          plugins = [
            "zsh-users/zsh-completions"
          ];
        };

        # .zshrc
        initExtra = ''
          if [ $(uname) = "Darwin" ]; then
            path=("$HOME/.nix-profile/bin" "/run/wrappers/bin" "/etc/profiles/per-user/$USER/bin" "/nix/var/nix/profiles/default/bin" "/run/current-system/sw/bin" "/opt/homebrew/bin" $path)
          fi
        '';

        # Tweak settings for history
        history = {
          save = 1000;
          size = 1000;
          path = "$HOME/.cache/zsh_history";
        };

        # Set some aliases
        shellAliases = {
          ".." = "cd ..";
          c = "xsel -i";
          v = "xsel -o";
          cat = "bat";
          diff = "batdiff";
          man = "batman";
          grep = "batgrep";
          watch = "batwatch";
        };
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      # zoxide replaces cd
      zoxide = {
        enable = true;
        enableZshIntegration = true;

        options = ["--cmd" "cd"];
      };

      # bat replaces cat
      bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batdiff
          batman
          batgrep
          batwatch
        ];
      };

      # lsd replaceses ls
      lsd = {
        enable = true;
        enableAliases = true;
      };

      # Starship for the prompt
      starship = {
        enable = true;

        settings = {
          right_format = "$git_branch$git_state$git_status$shell$nix_shell";

          format = "$username$hostname$directory$character$cmd_duration[](red)[](yellow)[](green) ";

          # $line_break\

          add_newline = false;

          username = {
            style_user = "purple bold";
            style_root = "red bold";
            format = "[$user]($style) ";
            disabled = false;
            show_always = true;
          };

          hostname = {
            ssh_only = true;
            format = "[$ssh_symbol](bold blue)@[$hostname](bold red) ";
            trim_at = ".local";
            disabled = false;
          };

          directory = {
            style = "blue";
            read_only = " ";
            truncation_length = 2;
            fish_style_pwd_dir_length = 1;
            # truncate_to_repo = false;
            # truncation_symbol = "/";
          };

          character = {
            format = "$symbol";
            success_symbol = "";
            error_symbol = "[󱎘 ](red)";
            vimcmd_symbol = "[ ](green)";
          };

          shell = {
            # disabled = false;
            format = "[$indicator]($style) ";
            style = "cyan";
            zsh_indicator = "zsh";
            fish_indicator = "󰈺";
            powershell_indicator = ">_";
          };

          git_branch = {
            format = "[$branch ]($style)";
            style = "bright-black";
          };

          git_status = {
            # format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
            format = "([\\[$all_status$ahead_behind\\]]($style) )";
            style = "cyan";
            # conflicted = "​";
            # untracked = "​";
            modified = "";
            # staged = "​";
            # renamed = "​";
            deleted = "󱎘";
            stashed = "≡";
          };

          git_state = {
            format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
            style = "bright-black";
          };

          cmd_duration = {
            format = "[$duration]($style) ";
            style = "yellow";
          };

          nix_shell = {
            format = "[$symbol $state]($style)";
            symbol = "";
          };
        };
      };

      # Yazi file manager
      yazi = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
