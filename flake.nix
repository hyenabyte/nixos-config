{
  description = ''

    ░█░█░█░█░█▀▀░█▀█░█▀█░█▀▀░░░█▀█░▀█▀░█░█░█▀█░█▀▀░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
    ░█▀█░░█░░█▀▀░█░█░█▀█░▀▀█░░░█░█░░█░░▄▀▄░█░█░▀▀█░░░█░░░█░█░█░█░█▀▀░░█░░█░█
    ░▀░▀░░▀░░▀▀▀░▀░▀░▀░▀░▀▀▀░░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀

    Definitions for all my machines and dot files
  '';

  # All inputs for the system
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Snowfall
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Darwin support
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System Image Generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nur for firefox extensions
    nur.url = "github:nix-community/nur";

    # VSCode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
      #inputs.flake-utils.follows = "flake-utils";
    };

    # Age encryption
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SSH Keys
    # ssh-keys = {
    #   url = "https://codeberg.org/hyenabyte.keys";
    #   flake = false;
    # };

    # Private secrets
    secrets = {
      url = "git+ssh://git@codeberg.org/hyenabyte/secrets.git?ref=main";
      flake = false;
    };
  };

  # All outputs for the system (configs)
  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      snowfall = {
        meta = {
          name = "hyenas-config";
          title = "hyenas config";
        };
        namespace = "hyenabyte";
        root = ./landscape;
      };
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [];
      };
      overlays = with inputs; [
        nix-vscode-extensions.overlays.default
        nur.overlay
      ];
      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
        secrets.outPath
      ];
      systems.modules.darwin = with inputs; [
        home-manager.darwinModules.home-manager
        agenix.darwinModules.default
        secrets.outPath
      ];
    };
}
