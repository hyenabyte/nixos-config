{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg =
    config.modules.packages;
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
      blender
      inkscape
      krita
      lutris
      spotify
      steam
      vesktop
      vlc

      # Development
      # beekeeper-studio

      # Customization
    ];
  };
}
