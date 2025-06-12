{ pkgs
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  # Work Laptop

  # Make firefox behave in wayland
  environment.variables.MOZ_ENABLE_WAYLAND = 0;

  imports = [
    # System hardware configuration
    # TODO: Enable hardware
    # ./hardware-configuration.nix
    # (import ./disks/boot.nix { device = "/dev/nvme0n1"; })
  ];

  environment.systemPackages = [
    pkgs."${namespace}".wallpapers
  ];

  ${namespace} = {
    desktop = {
      gnome = enabled;
      dm.gdm = enabled;
      hyprland = {
        enable = true;
        monitor = [
          # TODO: enable correct monitor
          # "desc:Monitor name goes here, preferred, 0x0, 1"
        ];
      };
    };

    suites.common = enabled;

    hardware = {
      bluetooth = enabled;
      wireless = {
        enable = true;
        # enableIwd = true;
      };
      audio.pipewire = enabled;
    };

    services.tailscale = enabled;

    security = {
      agenix = {
        enable = true;
        # NOTE: since the ssh key doesn't exist in /home/{user}/.ssh on boot, age has to look for it in the persist folder instead
        sshKey = "/persist/system/home/hyena/.ssh/id_ed25519";
      };
      keyring.gnome-keyring = {
        enable = true;
        enableSeahorse = true;
      };
    };

    system.tty = enabled;
    system.boot.impermanence = enabled;
  };

  # TODO: set correct version on setup
  # ! DO NOT CHANGE !
  system.stateVersion = "25.05";
}
