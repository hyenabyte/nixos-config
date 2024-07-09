{
  pkgs,
  lib,
  config,
  inputs,
  namespace,
  system,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.agenix;
in {
  options.${namespace}.security.agenix = {enable = mkEnableOption "Enable Agenix";};
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.age
      inputs.agenix.packages.${system}.default
    ];
  };
}
