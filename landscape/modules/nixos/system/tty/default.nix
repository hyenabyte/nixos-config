{ lib
, config
, namespace
, pkgs
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.tty;
in
{
  options.${namespace}.system.tty = { enable = mkEnableOption "tty"; };
  config = mkIf cfg.enable {
    console = {
      earlySetup = true;

      packages = with pkgs; [ terminus_font ];
      font = "${pkgs.terminus_font}/share/consolefonts/ter-118n.psf.gz";

      # font = "Agave Nerd Font Mono";
      colors = [
        "09090a"
        "97484f"
        "73794f"
        "a17a2c"
        "4c7288"
        "a16a8d"
        "407467"
        "bdb193"
        "1c1b1a"
        "d16469"
        "a6ae5a"
        "dbb560"
        "77afca"
        "c193b0"
        "72afa0"
        "ebe0bc"
      ];
    };
  };
}
