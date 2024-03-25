{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nix-ld;
in {
  options.nix-ld = {enable = mkEnableOption "nix-ld";};
  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
