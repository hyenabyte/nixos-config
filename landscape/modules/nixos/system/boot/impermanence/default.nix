{ lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.boot.impermanence;
in
{
  options.${namespace}.system.boot.impermanence = with types; {
    enable = mkEnableOption "impermanence";
    users = mkOpt (listOf str) [ "hyena" ] "The users to enable persistance for";
  };
  config = mkIf cfg.enable {
    boot.initrd.postDeviceCommands = lib.mkAfter ''
      mkdir /btrfs_tmp
      mount /dev/root_vg/root /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';

    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
      ];
      files = [
        "/etc/machine-id"
        { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
      ];

      users = foldl
        (acc: user: acc // {
          "${user}" = {
            directories = [
              "Downloads"
              "Music"
              "Pictures"
              "Documents"
              "Videos"
              "Workspace"
              "VirtualBox VMs"
              { directory = ".gnupg"; mode = "0700"; }
              { directory = ".ssh"; mode = "0700"; }
              { directory = ".nixops"; mode = "0700"; }
              { directory = ".local/share/keyrings"; mode = "0700"; }
              ".local/share/direnv"
              # {
              #   directory = ".local/share/Steam";
              #   method = "symlink";
              # }
            ];
            # files = [
            #   ".screenrc"
            # ];
          };
        })
        { }
        cfg.users;
    };

    # Allow home manager impermanance to mount its directories
    programs.fuse.userAllowOther = true;
  };
}
