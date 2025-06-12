{ lib
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

    apps = { };

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
