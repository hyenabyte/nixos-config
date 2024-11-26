{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.creative;
in
{
  options.${namespace}.suites.creative = with types; {
    enable =
      mkEnableOption "Enable Creative Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gimp
      inkscape
      # blender
      krita
    ];

    ${namespace} = {
      apps = { };
    };
  };
}
