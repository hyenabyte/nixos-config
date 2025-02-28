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
    # pkgs."${namespace}".mixitup
  ];

  # Fix firefox crashing in wayland
  environment.variables.MOZ_ENABLE_WAYLAND = 0;

  ${namespace} = {
    desktop = {
      dm.ly = enabled;
      hyprland = enabled;
      plasma = enabled;
    };

    suites = {
      common = enabled;
      games = enabled;
      multimedia = enabled;
      development = enabled;
      creative = enabled;
    };

    hardware = {
      bluetooth = enabled;
      nvidia = enabled;
      wireless = enabled;
      audio.pipewire = enabled;
    };

    virtualisation = {
      qemu = enabled;
    };

    tools = {
      input-remapper = enabled;
      mullvad = enabled;
    };

    security = {
      agenix = {
        enable = true;
      };
    };
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "23.11";
}
