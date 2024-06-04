{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.virtual-box;
in {
  options.virtual-box = {enable = mkEnableOption "virtual-box";};
  config = mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];
  };
}
