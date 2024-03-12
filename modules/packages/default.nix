{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg =
    config.modules.packages;
  screen = pkgs.writeShellScriptBin "screen" ''${builtins.readFile ./screen}'';
  bandw = pkgs.writeShellScriptBin "bandw" ''${builtins.readFile ./bandw}'';
  maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';
in {
  options.modules.packages = {enable = mkEnableOption "packages";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Terminal
      antidote
      croc
      lazygit
      neofetch
      xh
      xsel
      yazi

      # Nix
      nil
      alejandra

      # Applications
      vesktop
      steam
      krita
      blender
      inkscape
      spotify
    ];
  };
}
