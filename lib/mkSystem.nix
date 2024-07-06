{self, ...} @ inputs: pkgs: system: hostname: user: let
  isDarwin = system == "aarch64-darwin";
  systemMaker =
    if isDarwin
    then inputs.nix-darwin.lib.darwinSystem
    else pkgs.lib.nixosSystem;
  systemPrefix =
    if system == "aarch64-darwin"
    then "darwin"
    else "nixos";
  systemModules =
    if isDarwin
    then [
      inputs.agenix.darwinModules.default
      inputs.home-manager.darwinModules.home-manager
    ]
    else [
      inputs.agenix.nixosModules.default
      inputs.home-manager.nixosModules.home-manager

      "${self}/users/${user}"
    ];
in
  systemMaker {
    inherit system;
    # system = system;
    specialArgs = {inherit inputs user self;};

    modules =
      systemModules
      ++ [
        # Hostname
        {networking.hostName = hostname;}
        # Default system config
        "${self}/hosts/${systemPrefix}"
        # Host specific system config
        "${self}/hosts/${systemPrefix}/${hostname}"

        # Secrets
        inputs.secrets.outPath
        # Home manager config
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            extraSpecialArgs = {inherit inputs user;};
            backupFileExtension = "bak";

            users.${user} = {
              imports = [
                # Agenix
                inputs.agenix.homeManagerModules.default
                # User Modules
                "${self}/modules/packages"
                # Default user config
                "${self}/users/${user}/home.nix"
                # Host specific user config
                "${self}/hosts/${systemPrefix}/${hostname}/user.nix"
              ];
            };
          };
        }
      ];
  }
