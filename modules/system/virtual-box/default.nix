{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.virtual-box;
in {
  options.modules.virtual-box = {enable = mkEnableOption "virtual-box";};
  config = mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = ["hyena"];
  };
}
