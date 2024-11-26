{ pkgs
, config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.shell.addons.bat;
  extraPackagesDefault = with pkgs.bat-extras; [
    batdiff
    batman
    batgrep
    batwatch
  ];
in
{
  options.${namespace}.shell.addons.bat = with types; {
    enable = mkEnableOption "bat";
    enableZshIntegration = mkBoolOpt false "Enable ZSH Aliases";
    extraPackages = mkPackageListOption extraPackagesDefault "Extra packages to use with bat";
  };

  config = mkIf cfg.enable {
    # bat replaces cat
    programs.bat = {
      enable = true;
      extraPackages = cfg.extraPackages;
    };

    programs.zsh = mkIf cfg.enableZshIntegration {
      shellAliases = {
        cat = "bat";
        diff = "batdiff";
        man = "batman";
        grep = "batgrep";
        watch = "batwatch";
      };
    };
  };
}
