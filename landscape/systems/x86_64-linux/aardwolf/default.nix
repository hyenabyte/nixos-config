{ pkgs
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  # My Desktop PC

  environment.variables.MOZ_ENABLE_WAYLAND = 0;

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    pkgs."${namespace}".wallpapers
    # pkgs."${namespace}".phanpy
    # pkgs."${namespace}".mixitup
    winetricks
    wineWowPackages.stable
    wine
  ];

  ${namespace} = {
    desktop = {
      dm.greetd = {
        enable = true;
        enableKwallet = true;
      };
      hyprland = enabled;
      plasma = enabled;
    };

    apps.steam = enabled;
    suites.common = enabled;

    hardware = {
      bluetooth = enabled;
      nvidia = enabled;
      wireless = enabled;
      audio.pipewire = enabled;
      xboxcontroller = enabled;
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
      keyring = enabled;
    };

    system.tty = enabled;
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "23.11";
}
