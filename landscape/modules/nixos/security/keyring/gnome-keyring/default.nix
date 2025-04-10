{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.keyring.gnome-keyring;
in
{
  options.${namespace}.security.keyring.gnome-keyring = {
    enable = mkEnableOption "gnome-keyring";
    enableSeahorse = mkEnableOption "Seahorse";
    enableGreetd = mkOpt types.bool false "Unlock keyring on login with greetd";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = mkIf cfg.enableSeahorse [ pkgs.seahorse ];
    services.gnome.gnome-keyring = {
      enable = true;
    };

    security.pam = {
      services.greetd = mkIf cfg.enableGreetd {
        enableGnomeKeyring = true;
      };
    };
  };
}
