{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.agenix.homeManagerModules.default
    ../../../modules/packages
    ../../../users/hyena/home.nix
  ];

  config = {
    home.stateVersion = "23.11";

    # Modules
    modules = {
      # cli
      zellij.enable = true;

      # gui
      alacritty.enable = true;
      firefox.enable = true;
    };

    # Packages
    home.packages = with pkgs; [
      ### Applications   ###

      ### Social         ###

      ### Multimedia     ###

      ### Gaming         ###

      ### Graphical work ###

      ### Development    ###

      ### Customization  ###
    ];
  };
}
