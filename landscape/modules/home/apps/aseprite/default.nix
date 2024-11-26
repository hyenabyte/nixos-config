{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.aseprite;

  configDir = "aseprite";

  mkConfigFolder = folderName:
    lib.foldl
      (
        acc: file:
          let
            fileName = builtins.baseNameOf file;
          in
          acc // { "${configDir}/${folderName}/${fileName}".source = ./. + "/${folderName}/${file}"; }
      )
      { }
      (builtins.attrNames (builtins.readDir (./. + "/${folderName}")));

  palettes = mkConfigFolder "palettes";
  scripts = mkConfigFolder "scripts";
in
{
  options.${namespace}.apps.aseprite = with types; {
    enable = mkEnableOption "Enable Aseprite";
    package = mkOpt package pkgs.aseprite "Which Aseprite package to use";
  };
  config = mkIf cfg.enable {
    # home.packages = [
    #   cfg.package
    # ];

    xdg.configFile =
      {
        # "vesktop/themes/midnight-everforest.theme.css".source = ./themes/midnight-everforest.theme.css;
      }
      // palettes
      // scripts;
  };
}
