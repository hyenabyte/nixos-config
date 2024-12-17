{ pkgs
, lib
, namespace
, inputs
, system
, ...
}:
with lib;
with lib.${namespace}; {
  # My Desktop PC

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [
    pkgs."${namespace}".wallpapers
    # pkgs."${namespace}".phanpy
    pkgs."${namespace}".mixitup
  ];

  # Fix firefox crashing in wayland
  environment.variables.MOZ_ENABLE_WAYLAND = 0;

  ${namespace} = {
    desktop = {
      # dm.ly = enabled;
      hyprland = enabled;
      dm.gdm = enabled;
      gnome = enabled;
    };

    suites = {
      common = enabled;
      desktop = enabled;
      games = enabled;
      multimedia = enabled;
      development = enabled;
      creative = enabled;
    };

    hardware = {
      bluetooth = enabled;
      nvidia = enabled;
      wireless = enabled;
    };

    virtualisation = {
      qemu = enabled;
    };

    security = {
      keyring = {
        enable = true;
        enableSeahorse = true;
      };
    };

    tools = {
      input-remapper = enabled;
    };
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "23.11";
}
