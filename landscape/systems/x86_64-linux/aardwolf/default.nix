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
    (import ./disks/boot.nix { device = "/dev/nvme0n1"; })
    (import ./disks/store.nix { device = "/dev/sdb"; })
  ];

  environment.systemPackages = with pkgs; [
    pkgs."${namespace}".wallpapers
    # winetricks
    # wineWowPackages.stable
    # wine
  ];

  ${namespace} = {
    desktop = {
      dm.greetd = {
        enable = true;
        # Run Hyprland with dbus for nautilus to work properly with samba shares
        command = "dbus-run-session Hyprland";
        # enableKwallet = true;
      };
      hyprland = enabled;
      # plasma = enabled;
    };

    apps.steam = enabled;
    suites.common = enabled;

    hardware = {
      bluetooth = enabled;
      nvidia = enabled;
      wireless = {
        enable = true;
        # enableIwd = true;
      };
      audio.pipewire = enabled;
      # xboxcontroller = enabled;
    };

    # virtualisation = {
    #   qemu = enabled;
    # };

    # tools = {
    #   input-remapper = enabled;
    #   mullvad = enabled;
    #   partitionmanager = enabled;
    # };

    security = {
      agenix.enable = true;
      # keyring.kwallet = {
      #   enable = true;
      #   enableGreetd = true;
      #   users = [ "hyena" ];
      # };
    };

    system.tty = enabled;
    system.boot.impermanence = enabled;
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "24.11";
}
