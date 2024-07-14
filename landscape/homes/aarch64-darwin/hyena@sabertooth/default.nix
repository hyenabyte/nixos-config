{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace}; {
  hyenabyte = {
    user = enabled;
    shell.zsh = enabled;

    apps = {
      # firefox = enabled;
      # logseq = enabled;
      # vesktop = enabled;
    };

    cli = {
      bottom = enabled;
      helix = {
        enable = true;
        defaultEditor = true;
      };
      home-manager = enabled;
      hyfetch = enabled;
      zellij = enabled;
      lazygit = enabled;
    };

    tools = {
      direnv = enabled;
      git = enabled;
    };
  };

  home.sessionPath = ["$HOME/bin"];

  home.stateVersion = "23.11";
}
