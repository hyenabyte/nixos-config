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
    pkgs.chromium
    pkgs.croc
    # pkgs.caffeine-ng
    pkgs.tigervnc
    pkgs.deluge
    pkgs.slack
    pkgs."${namespace}".wallpapers
    # pkgs."${namespace}".phanpy
  ];

  # Fix firefox crashing in wayland
  environment.variables.MOZ_ENABLE_WAYLAND = 0;

  ${namespace} = {
    desktop = {
      hyprland = enabled;
    };

    suites = {
      common = enabled;
      desktop = enabled;
      games = enabled;
      multimedia = enabled;
      development = enabled;
      social = enabled;
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
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "23.11";
}
