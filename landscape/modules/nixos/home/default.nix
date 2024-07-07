{
  options,
  inputs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.home;
in {
  imports = with inputs; [home-manager.nixosModules.home-manager];

  options.${namespace}.home = with types; {
    file =
      mkOption attrs {}
      "A set of files to be managed by home-manager's <option>home.file</option>.";
    configFile =
      mkOption attrs {}
      "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    programs = mkOption attrs {} "Programs to be managed by home-manager.";
    extraOptions = mkOption attrs {} "Options to pass directly to home-manager.";

    persist = mkOption attrs {} "Files and directories to persist in the home";
  };

  config = {
    ${namespace}.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.${namespace}.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.${namespace}.home.configFile;
      programs = mkAliasDefinitions options.${namespace}.home.programs;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPackages = true;

      users.${config.${namespace}.user.name} =
        mkAliasDefinitions options.${namespace}.home.extraOptions;
    };

    environment.persistence."/persist".users.${config.user.name} = mkIf options.impermanence.enable.value (mkAliasDefinitions options.home.persist);
  };
}
