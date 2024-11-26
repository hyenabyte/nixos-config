{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.homebrew;
in
{
  options.${namespace}.services.homebrew = with types; {
    enable = mkBoolOpt false "Enable Homebrew";
    brews = mkOpt (listOf str) [ ] "Brews to install.";
    casks = mkOpt (listOf str) [ ] "Casks to install.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
        upgrade = true;
      };

      brewPrefix = "/opt/homebrew/bin";

      caskArgs = {
        # no_quarantine = true;
      };

      brews = [ ] ++ cfg.brews;
      casks = [ ] ++ cfg.casks;
    };
  };
}
