{ lib
, pkgs
, namespace
, ...
}:
with lib.${namespace}; {
  hyenabyte = {
    user = enabled;
    shell.zsh = enabled;

    apps = { };

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
