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
      hyprland = {
        enable = true;
        monitor = [
          "desc:LG Electronics LG TV SSCR2 0x01010101, 3840x2160@119.88, 0x0, 1"
          # "desc:LG Electronics LG ULTRAGEAR 209MAQQFWE16, preferred, 0x0, 1"
          # "desc:AOC Q27P1B GNXJCHA039883, preferred, 2560x-550, 1, transform, 1"
        ];
      };
    };

    apps.steam = enabled;
    suites.common = enabled;
    suites.server = enabled;

    hardware = {
      bluetooth = enabled;
      nvidia = enabled;
      wireless = {
        enable = true;
        enableIwd = true;
      };
      audio.pipewire = enabled;
      xboxcontroller = enabled;
    };

    services.tailscale = enabled;

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
