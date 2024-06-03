{
  description = "NixOS configuration";

  # All inputs for the system
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/nur";
  };

  # All outputs for the system (configs)
  outputs = {
    home-manager,
    nixpkgs,
    nix-darwin,
    nur,
    ...
  } @ inputs: let
    # system = "x86_64-linux"; #current system
    # pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    # lib = nixpkgs.lib;

    mkSystem = pkgs: system: hostname:
      if system == "aarch64-darwin"
        then nix-darwin.lib.darwinSystem {
          system = system;
          specialArgs = {inherit inputs;};

          modules = [
            {networking.hostName = hostname;}
            # ./hosts/darwin
            (./. + "hosts/darwin/${hostname}")
          ];
        }

        else pkgs.lib.nixosSystem {
          system = system;
          specialArgs = {inherit inputs;};

          modules = [
            {networking.hostName = hostname;}
            (./. + "/hosts/nixos/${hostname}")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = {inherit inputs;};
                # Home manager config (configures programs like firefox, zsh, eww, etc)
                users.hyena = ./. + "/hosts/nixos/${hostname}/user.nix";
              };
            }
          ];
        };
  in {
    nixosConfigurations = {
      # Now, defining a new system is can be done in one line
      #                                       Architecture      Hostname
      aardwolf =    mkSystem inputs.nixpkgs   "x86_64-linux"    "aardwolf";
      possum =      mkSystem inputs.nixpkgs   "x86_64-linux"    "possum";
    };
    darwinConfigurations = {
      sabertooth =  mkSystem inputs.nixpkgs   "aarch64-darwin"  "sabertooth";
    };
  };
}
