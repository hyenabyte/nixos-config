{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.keyring.kwallet;
in
{
  options.${namespace}.security.keyring.kwallet = with types; {
    enable = mkEnableOption "kwallet";
    enableGreetd = mkOpt bool false "Unlock kwallet on greetd login";
  };
  config = mkIf cfg.enable {
    security.pam = {
      services.kwallet = {
        # name = "kwallet";
        enableKwallet = true;
        package = pkgs.kdePackages.kwallet-pam;
      };

      services.greetd = mkIf cfg.enableGreetd {
        enableKwallet = true;
      };
    };
  };
}
