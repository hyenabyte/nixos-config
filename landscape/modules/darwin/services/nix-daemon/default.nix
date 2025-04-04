{ lib
, config
, namespace
, ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkOpt enabled;

  cfg = config.${namespace}.services.nix-daemon;
in
{
  options.${namespace}.services.nix-daemon = {
    enable = mkOpt types.bool true "Enable the Nix daemon";
  };

  config = mkIf cfg.enable { services.nix-daemon = enabled; };
  # services.nix-daemon.enable = lib.mkForce true;
}
