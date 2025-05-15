{
  description = ''

    ░█░█░█░█░█▀▀░█▀█░█▀█░█▀▀░░░█▀█░▀█▀░█░█░█▀█░█▀▀░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
    ░█▀█░░█░░█▀▀░█░█░█▀█░▀▀█░░░█░█░░█░░▄▀▄░█░█░▀▀█░░░█░░░█░█░█░█░█▀▀░░█░░█░█
    ░▀░▀░░▀░░▀▀▀░▀░▀░▀░▀░▀▀▀░░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀

    Definitions for all my machines and dot files
  '';

  # All inputs for the system
  inputs =
    {
      # Nixpkgs
      nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
      unstable.url = "github:nixos/nixpkgs/nixos-unstable";

      # Snowfall
      snowfall-lib.url = "github:snowfallorg/lib";
      snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

      # Flake
      snowfall-flake.url = "github:snowfallorg/flake";
      snowfall-flake.inputs.nixpkgs.follows = "nixpkgs";

      # Home Manager
      home-manager.url = "github:nix-community/home-manager/release-24.11";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      # Impermanence
      impermanence.url = "github:nix-community/impermanence";

      # Disko
      disko.url = "github:nix-community/disko";
      disko.inputs.nixpkgs.follows = "nixpkgs";

      # Lix
      # https://lix.systems/ 
      lix.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      lix.inputs.nixpkgs.follows = "nixpkgs";

      # Stylix
      # https://github.com/danth/stylix
      stylix.url = "github:danth/stylix/release-24.11";
      stylix.inputs.nixpkgs.follows = "nixpkgs";

      # Darwin support
      darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      darwin.inputs.nixpkgs.follows = "nixpkgs";

      # Allow Nix installed apps to be launched
      mac-app-util.url = "github:hraban/mac-app-util";
      mac-app-util.inputs.nixpkgs.follows = "nixpkgs";

      # System Image Generators
      nixos-generators.url = "github:nix-community/nixos-generators";
      nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

      # Zen Browser
      # https://github.com/0xc000022070/zen-browser-flake
      # FIXME: remove this as soon as zen browser is availble in nixpkgs
      zen-browser.url = "github:0xc000022070/zen-browser-flake";
      zen-browser.inputs.nixpkgs.follows = "unstable";

      # Nix Minecraft
      # https://github.com/Infinidoge/nix-minecraft
      nix-minecraft.url = "github:Infinidoge/nix-minecraft";
      nix-minecraft.inputs.nixpkgs.follows = "unstable";

      # Age encryption
      # https://github.com/ryantm/agenix
      agenix.url = "github:ryantm/agenix";
      agenix.inputs.nixpkgs.follows = "nixpkgs";

      # Deployments
      # https://github.com/serokell/deploy-rs
      deploy-rs.url = "github:serokell/deploy-rs";
      deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

      # Private secrets
      secrets.url = "git+ssh://git@github.com/hyenabyte/nixos-secrets.git?ref=main";
      secrets.flake = false;
    };

  # All outputs for the system (configs)
  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
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
      };
    in
    lib.mkFlake
      {
        channels-config = {
          allowUnfree = true;
          # permittedInsecurePackages = [
          #   "electron-27.3.11"
          # ];
        };

        overlays = with inputs; [
          snowfall-flake.overlays.default
          nix-minecraft.overlay
          lix.overlays.default
        ];

        systems.modules.nixos = with inputs; [
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          nix-minecraft.nixosModules.minecraft-servers
          disko.nixosModules.default
          impermanence.nixosModules.impermanence
          # stylix.nixosModules.stylix
        ];

        systems.modules.darwin = with inputs; [
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          agenix.darwinModules.default
          stylix.darwinModules.stylix
        ];

        homes.modules = with inputs; [
          agenix.homeManagerModules.default
          impermanence.nixosModules.home-manager.impermanence
          stylix.homeManagerModules.stylix
        ];

        # Deployment nodes
        deploy.nodes = {
          possum = {
            hostname = "possum";
            profiles.system = {
              user = "root";
              sshUser = "hyena";
              interactiveSudo = true;
              # sudo = "doas -u";
              path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.possum;
            };
          };
        };
        #deploy = lib.mkDeploy { inherit (inputs) self; };

        checks =
          builtins.mapAttrs
            (_system: deploy-lib:
              deploy-lib.deployChecks inputs.self.deploy)
            inputs.deploy-rs.lib;
      }
    // {
      self = inputs.self;
    };
}
