{
  config,
  pkgs,
  ...
}: {
  home.stateVersion = "23.11";
  home.homeDirectory = lib.mkForce "/Users/hyena";

  programs.home-manager.enable = true;

  # imports = [
  #   inputs.nix-index-database.hmModules.nix-index
  #   inputs.agenix.homeManagerModules.default
  #   ../../users/notthebee/dots.nix
  #   ../../users/notthebee/age.nix
  #   ../../dots/tmux
  #   ../../dots/kitty
  # ];
}
