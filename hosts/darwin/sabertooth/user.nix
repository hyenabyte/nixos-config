{
  pkgs,
  lib,
  user,
  ...
}: {
  config = {
    home.stateVersion = "23.11";
    home.homeDirectory = lib.mkForce "/Users/${user}";

    programs.home-manager.enable = true;

    modules = {
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
      vscode.enable = true;
    };

    home.packages = with pkgs; [
      antidote
      croc
      lazygit
      hyfetch
      xh
      xsel
      yazi
      nil
      alejandra
    ];
  };
}
