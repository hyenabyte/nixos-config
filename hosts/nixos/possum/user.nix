{
  inputs,
  pkgs,
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
    };

    # Packages
    home.packages = with pkgs; [
    ];
  };
}
