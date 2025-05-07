{ config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = with types; {
    enable = mkEnableOption "Common Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      snowfallorg.flake
      disko
    ];

    ${namespace} = {
      tools = {
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

      cli = {
        isd = enabled;
      };

      security = {
        gpg = enabled;
        firewall = enabled;
        # doas = enabled;
      };

      system = {
        nix = enabled;
        boot.efi = enabled;
        fonts = enabled;
        locale = enabled;
        xkb = enabled;
      };
    };
  };
}
