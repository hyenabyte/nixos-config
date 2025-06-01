{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.hydra;
in
{
  options.${namespace}.services.hydra = { enable = mkEnableOption "hydra"; };
  config = mkIf cfg.enable {
    services.hydra = {
      enable = true;

      hydraURL = "http://possum:3000";
      notificationSender = "hydra@localhost"; # e-mail of hydra service
      buildMachinesFiles = [ ];
      useSubstitutes = true;
    };
  };
}
