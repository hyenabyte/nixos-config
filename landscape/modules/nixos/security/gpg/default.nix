{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.gpg;
in {
  options.${namespace}.security.gpg = {enable = mkEnableOption "gpg";};
  config = mkIf cfg.enable {
    # TODO

    programs.gpg = {
      enable = true;
    };

    # Fix pass
    # services.gpg-agent = {
    #     enable = true;
    #     pinentryFlavor = "qt";
    # };
  };
}
