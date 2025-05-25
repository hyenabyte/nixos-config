{ pkgs
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  # My Desktop PC

  # Make firefox behave in wayland
  environment.variables.MOZ_ENABLE_WAYLAND = 0;

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
    (import ./disks/boot.nix { device = "/dev/nvme0n1"; })
    (import ./disks/store.nix { device = "/dev/sdb"; })
  ];

  environment.systemPackages = with pkgs; [
    pkgs."${namespace}".wallpapers
    winetricks
    wineWowPackages.stable
    wine
  ];

  ${namespace} = {
    desktop = {
      # dm.greetd = {
      #   enable = true;
      #   # Run Hyprland with dbus for nautilus to work properly with samba shares
      #   command = "dbus-run-session Hyprland";
      #   # enableKwallet = true;
      # };
      # plasma = enabled;
      gnome = enabled;
      dm.gdm = enabled;
      hyprland = enabled;
    };

    apps.steam = enabled;
    suites.common = enabled;
    suites.server = enabled;

    hardware = {
      bluetooth = enabled;
      nvidia = enabled;
      wireless = {
        enable = true;
      };
      audio.pipewire = enabled;
      xboxcontroller = enabled;
    };

    virtualisation = {
      # qemu = enabled;
    };


    # tools = {
    #   input-remapper = enabled;
    #   mullvad = enabled;
    #   partitionmanager = enabled;
    # };

    services = {
      tailscale = enabled;
      # minecraft = enabled;
    };

    security = {
      agenix = {
        enable = true;
        # NOTE: since the ssh key doesn't exist in /home/{user}/.ssh on boot, age has to look for it in the persist folder instead
        sshKey = "/persist/system/home/hyena/.ssh/id_ed25519";
      };
      # keyring.kwallet = {
      #   enable = true;
      #   enableGreetd = true;
      #   users = [ "hyena" ];
      # };
      keyring.gnome-keyring = {
        enable = true;
        enableSeahorse = true;
        # enableGreetd = true;
      };
    };

    system.tty = enabled;
    system.boot.impermanence = enabled;
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "24.11";
}
