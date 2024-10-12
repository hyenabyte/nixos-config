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
      alacritty = enabled;
      firefox = enabled;
      # logseq = enabled;
      vesktop = enabled;
      # discord = enabled;
      # aseprite = enabled;
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
    };

    tools = {
      direnv = enabled;
      git = enabled;
    };
  };
}
