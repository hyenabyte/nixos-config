{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.logseq;
in {
  options.modules.logseq = {enable = mkEnableOption "logseq";};
  config = mkIf cfg.enable {
    home.packages = [
      pkgs.logseq
    ];

    # TODO: add logseq config
  };
}
