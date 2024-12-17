{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.keyring;
in
{
  options.${namespace}.security.keyring = {
    enable = mkEnableOption "keyring";
    enableSeahorse = mkEnableOption "Seahorse";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = mkIf cfg.enableSeahorse [ pkgs.seahorse ];
    services.gnome.gnome-keyring = {
      enable = true;
    };
  };
}
