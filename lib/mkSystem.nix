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
        # Default host config
        "${self}/hosts/${systemPrefix}"
        # Specific host config
        "${self}/hosts/${systemPrefix}/${hostname}"
        # Default user config
        (
          # Don't include user definition if a Darwin system
          pkgs.lib.strings.optionalString (!isDarwin) "${self}/users/${user}"
        )
        # Secrets
        inputs.secrets.outPath
        # Home manager config
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            extraSpecialArgs = {inherit inputs;};
            backupFileExtension = "bak";
            users.${user} = "${self}/hosts/${systemPrefix}/${hostname}/user.nix";
          };
        }
      ];
  }
