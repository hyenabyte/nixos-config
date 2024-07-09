# https://github.com/jakehamilton/config/blob/main/modules/nixos/nix/default.nix
{
  options,
  config,
  pkgs,
  lib,
  inputs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.nix;

  substituters-submodule = types.submodule ({name, ...}: {
    options = with types; {
      key = mkOpt (nullOr str) null "The trusted public key for this substituter.";
    };
  });
in {
  options.${namespace}.system.nix = with types; {
    enable = mkEnableOption "Enable Nix Configuration.";
    package = mkOpt package pkgs.nix "Which nix package to use.";

    default-substituter = {
      url = mkOpt str "https://cache.nixos.org" "The url for the substituter.";
      key = mkOpt str "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "The trusted public key for the substituter.";
    };

    extra-substituters = mkOpt (attrsOf substituters-submodule) {} "Extra substituters to configure.";
  };

  config = mkIf cfg.enable {
    assertions =
      mapAttrsToList
      (name: value: {
        assertion = value.key != null;
        message = "${namespace}.nix.extra-substituters.${name}.key must be set";
      })
      cfg.extra-substituters;

    environment.systemPackages = with pkgs; [
      nil
      alejandra
    ];

    nix = let
      users = ["root" config.${namespace}.user.name];
      # ++ optional config.services.hydra.enable "hydra";
    in {
      package = cfg.package;

      settings =
        {
          experimental-features = "nix-command flakes";
          http-connections = 50;
          # warn-dirty = false;
          log-lines = 50;
          # sandbox = "relaxed";
          auto-optimise-store = true;
          trusted-users = users;
          allowed-users = users;

          substituters =
            [cfg.default-substituter.url]
            ++ (mapAttrsToList (name: value: name) cfg.extra-substituters);
          trusted-public-keys =
            [cfg.default-substituter.key]
            ++ (mapAttrsToList (name: value: value.key) cfg.extra-substituters);
        }
        // (lib.optionalAttrs config.${namespace}.tools.direnv.enable {
          keep-outputs = true;
          keep-derivations = true;
        });

      gc = {
        automatic = true;
        interval = {
          Day = 7;
        };
        options = "--delete-older-than 30d";
        user = config.${namespace}.user.name;
      };

      # flake-utils-plus
      # generateRegistryFromInputs = true;
      # generateNixPathFromInputs = true;
      # linkInputs = true;
    };
  };
}
