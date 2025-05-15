{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.server;
in
{
  options.${namespace}.suites.server = with types; {
    enable = mkEnableOption "Enable Server Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty.terminfo
      ghostty.terminfo
    ];

    ${namespace} = {
      cli = {
        lazygit = enabled;
      };

      virtualisation = {
        podman = enabled;
      };

      services = {
        openssh = enabled;
      };

      security = {
        fail2ban = enabled;
      };
    };
  };
}
