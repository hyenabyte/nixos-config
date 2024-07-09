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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Darwin support
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
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

    # Deployments
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SSH Keys
    ssh-keys = {
      url = "https://github.com/hyenabyte.keys";
      flake = false;
    };

    # Private secrets
    secrets = {
      url = "git+ssh://git@github.com/hyenabyte/nixos-secrets.git?ref=main";
      flake = false;
    };
  };

  # All outputs for the system (configs)
  outputs = {
    home-manager,
    nixpkgs,
    nix-darwin,
    nur,
    agenix,
    ...
  } @ inputs: let
    mkSystem = (import ./lib inputs).mkSystem;
  in {
    # NixOS Configurations
    nixosConfigurations = {
      # Now, defining a new system is can be done in one line
      #                                  Architecture   Hostname
      aardwolf = mkSystem inputs.nixpkgs "x86_64-linux" "aardwolf" "hyena";
      possum = mkSystem inputs.nixpkgs "x86_64-linux" "possum" "hyena";
      virtuallynx = mkSystem inputs.nixpkgs "x86_64-linux" "virtuallynx" "hyena";
    };

    # Darwin Configurations
    darwinConfigurations = {
      sabertooth = mkSystem inputs.nixpkgs "aarch64-darwin" "sabertooth" "hyena";
    };

    # Deployment nodes
    deploy.nodes = {
      aardwolf = {
        hostname = "aardwolf";
        profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.aardwolf;
        };
      };
      possum = {
        hostname = "possum";
        profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.possum;
        };
      };
    };

    checks =
      builtins.mapAttrs
      (_system: deploy-lib:
        deploy-lib.deployChecks inputs.self.deploy)
      inputs.deploy-rs.lib;
  };
}
