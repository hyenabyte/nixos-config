{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.shell.addons.starship;
in
{
  options.${namespace}.shell.addons.starship = with types; {
    enable = mkEnableOption "Starship";
  };

  config = mkIf cfg.enable {

    # TODO support for multiple prompt definitions

    programs.starship = {
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
  };
}
