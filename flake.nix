{
  description = ''
    ░█░█░█░█░█▀▀░█▀█░█▀█░█▀▀░░░█▀█░▀█▀░█░█░█▀█░█▀▀░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
    ░█▀█░░█░░█▀▀░█░█░█▀█░▀▀█░░░█░█░░█░░▄▀▄░█░█░▀▀█░░░█░░░█░█░█░█░█▀▀░░█░░█░█
    ░▀░▀░░▀░░▀▀▀░▀░▀░▀░▀░▀▀▀░░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀

    Definitions for all my machines and dot files
  '';

  # All inputs for the system
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nur.url = "github:nix-community/nur";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
      #inputs.flake-utils.follows = "flake-utils";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    secrets = {
      url = "git+ssh://git@codeberg.org/hyenabyte/secrets.git?ref=main";
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
    mkSystem = pkgs: system: hostname:
      if system == "aarch64-darwin"
      then
        nix-darwin.lib.darwinSystem {
          system = system;
          specialArgs = {inherit inputs;};

          modules = [
            {networking.hostName = hostname;}
            ./hosts/darwin
            (./. + "/hosts/darwin/${hostname}")
            #./users/hyena
            agenix.darwinModules.default
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = {inherit inputs;};
                backupFileExtension = "bak";
                users.hyena = ./. + "/hosts/darwin/${hostname}/user.nix";
              };
            }
          ];
        }
      else
        pkgs.lib.nixosSystem {
          system = system;
          specialArgs = {inherit inputs;};

          modules = [
            {networking.hostName = hostname;}
            ./hosts/nixos
            (./. + "/hosts/nixos/${hostname}")
            ./users/hyena
            inputs.secrets.outPath
            agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = {inherit inputs;};
                backupFileExtension = "bak";
                users.hyena = ./. + "/hosts/nixos/${hostname}/user.nix";
              };
            }
          ];
        };
  in {
    nixosConfigurations = {
      # Now, defining a new system is can be done in one line
      #                                  Architecture   Hostname
      aardwolf = mkSystem inputs.nixpkgs "x86_64-linux" "aardwolf";
      possum = mkSystem inputs.nixpkgs-stable "x86_64-linux" "possum";
      virtuallynx = mkSystem inputs.nixpkgs "x86_64-linux" "virtuallynx";
    };
    darwinConfigurations = {
      sabertooth = mkSystem inputs.nixpkgs-stable "aarch64-darwin" "sabertooth";
    };
  };
}
