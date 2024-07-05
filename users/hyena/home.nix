{pkgs, ...}: {
  imports = [
    ../../modules/packages
  ];

  config = {
    # Modules
    modules = {
      # cli
      bat.enable = true;
      bottom.enable = true;
      direnv.enable = true;
      fzf.enable = true;
      git.enable = true;
      gpg.enable = true;
      helix.enable = true;
      hyfetch.enable = true;
      lsd.enable = true;
      starship.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };

    # Packages
    home.packages = with pkgs; [
      ### Terminal       ###
      age
      croc
      lazygit
      ncdu
      xh
      xsel
      yazi

      ### Nix            ###
      alejandra
      nil
    ];
  };
}
