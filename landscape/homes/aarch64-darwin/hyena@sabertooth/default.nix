{ lib
, pkgs
, namespace
, ...
}:
with lib.${namespace}; {
  hyenabyte = {
    user = {
      enable = true;

      name = "hyena";
      fullName = "hyena";
      email = "hyena@hyenabyte.dev";
    };

    shell.zsh = enabled;

    apps = {
      alacritty = enabled;
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
      yazi = enabled;
    };

    tools = {
      direnv = enabled;
      git = enabled;
    };

    # style = enabled;
  };

  home.packages = with pkgs; [
    # signal-desktop
    # slack
    # bruno
    # vlc-bin
    # imagemagick
  ];

  home.sessionPath = [ "$HOME/bin" ];

  home.stateVersion = "23.11";
}
