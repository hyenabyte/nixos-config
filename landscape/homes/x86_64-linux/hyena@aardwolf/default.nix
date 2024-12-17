{ pkgs
, lib
, namespace
, ...
}:
with lib.${namespace}; {
  home.packages = with pkgs; [
    signal-desktop
    chromium
    deluge
    slack
    tigervnc
  ];

  hyenabyte = {
    user = enabled;
    shell.zsh = enabled;

    apps = {
      alacritty = enabled;
      kitty = enabled;
      firefox = enabled;
      obs-studio = enabled;
      logseq = enabled;
      vesktop = enabled;
      discord = enabled;
      aseprite = enabled;
      zed = enabled;
      zen-browser = enabled;
    };

    cli = {
      bottom = enabled;
      helix = {
        enable = true;
        defaultEditor = true;
      };
      home-manager = enabled;
      hyfetch = enabled;
      yazi = enabled;
      zellij = enabled;
    };

    tools = {
      direnv = enabled;
      git = enabled;
    };
  };
}
