{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.common;
in {
  options.${namespace}.suites.common = with types; {
    enable = mkEnableOption "Enable Common Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
    ];

    ${namespace} = {
      cli = {
        bottom = enabled;
        helix = {
          enable = true;
          defaultEditor = true;
        };
        hyfetch = enabled;
      };

      tools = {
        git = enabled;
        ssh = enabled;
        nix-ld = enabled;
      };

      hardware = {
        networking = enabled;
      };

      services = {
        tailscale = enabled;
        printing = enabled;
      };

      security = {
        gpg = enabled;
      };

      system = {
        nix = enabled;
        boot.efi = enabled;
        shell.zsh = enabled;
        fonts = enabled;
        locale = enabled;
        xkb = enabled;
      };
    };
  };
}
