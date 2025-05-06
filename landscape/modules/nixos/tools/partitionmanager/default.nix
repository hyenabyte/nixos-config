{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.partitionmanager;
in
{
  options.${namespace}.tools.partitionmanager = with types; {
    enable = mkEnableOption "KDE Partition Manager";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.exfatprogs ];
    programs.partition-manager = {
      enable = true;
    };
  };
}
