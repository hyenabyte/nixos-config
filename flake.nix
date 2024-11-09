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
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Snowfall
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake
    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Darwin support
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System Image Generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-ld
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nur for firefox extensions
    nur.url = "github:nix-community/nur";

    # Zen Browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # VSCode extensions
    # nix-vscode-extensions = {
    #   url = "github:nix-community/nix-vscode-extensions";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   #inputs.flake-utils.follows = "flake-utils";
    # };

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
  outputs = inputs: let
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
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-27.3.11"
        ];
      };

      overlays = with inputs; [
        # nix-vscode-extensions.overlays.default
        nur.overlay
        snowfall-flake.overlays.default
      ];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
        nix-ld.nixosModules.nix-ld
        secrets.outPath
      ];

      systems.modules.darwin = with inputs; [
        home-manager.darwinModules.home-manager
        agenix.darwinModules.default
        secrets.outPath
      ];

      # Deployment nodes
      deploy.nodes = {
        aardwolf = {
          hostname = "aardwolf";
          profiles.system = {
            user = "root";
            sshUser = "hyena";
            sudo = "doas -u";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.aardwolf;
          };
        };
        possum = {
          hostname = "possum";
          profiles.system = {
            user = "root";
            sshUser = "hyena";
            sudo = "doas -u";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.possum;
          };
        };
        badger = {
          hostname = "badger";
          profiles.system = {
            user = "root";
            sshUser = "hyena";
            sudo = "doas -u";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.badger;
          };
        };
        weasel = {
          hostname = "weasel";
          profiles.system = {
            user = "root";
            sshUser = "hyena";
            sudo = "doas -u";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.weasel;
          };
        };
      };
      # deploy = lib.hyenabyte.mkDeploy {inherit (inputs) self;};

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
