{ options
, inputs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.home;
in
{
  imports = with inputs; [ home-manager.nixosModules.home-manager ];

  options.${namespace}.home = with types; {
    file =
      mkOpt attrs { }
        "A set of files to be managed by home-manager's <option>home.file</option>.";
    configFile =
      mkOpt attrs { }
        "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    programs = mkOpt attrs { } "Programs to be managed by home-manager.";
    services = mkOpt attrs { } "Services to be managed by home-manager.";
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";

    # persist = mkOpt attrs {} "Files and directories to persist in the home";
  };

  config = {
    hyenabyte.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.${namespace}.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.${namespace}.home.configFile;
      programs = mkAliasDefinitions options.${namespace}.home.programs;
      services = mkAliasDefinitions options.${namespace}.home.services;
    };

    snowfallorg.users.${config.${namespace}.user.name}.home.config =
      config.${namespace}.home.extraOptions;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      # Fix: Backup colliding files instead of exit with an error
      backupFileExtension = "hm-bak";

      # users.${config.${namespace}.user.name} =
      #   {
      #     imports = [
      #       inputs.agenix.homeManagerModules.default
      #     ];
      #   }
      #   // mkAliasDefinitions options.${namespace}.home.extraOptions;
    };

    # environment.persistence."/persist".users.${config.${namespace}.user.name} = mkIf options.impermanence.enable.value (mkAliasDefinitions options.home.persist);
  };
}
