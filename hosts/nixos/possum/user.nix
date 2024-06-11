{pkgs, ...}: {
  imports = [../../../modules/packages];

  config = {
    home.stateVersion = "23.11";

    # Modules
    modules = {
      # cli
      bat.enable = true;
      bottom.enable = true;
      direnv.enable = true;
      git.enable = true;
      gpg.enable = true;
      helix.enable = true;
      lsd.enable = true;
      starship.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };

    # Packages
    home.packages = with pkgs; [
      # Terminal
      antidote
      croc
      lazygit
      neofetch
      xh
      xsel
      yazi

      # Nix
      nil
      alejandra
    ];
  };
}
