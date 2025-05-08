{ device ? throw "Provide device", ... }:
{
  disko.devices = {
    disk.store = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          store = {
            name = "store";
            size = "100%";
            content = {
              type = "luks";
              name = "crypted_store";

              settings = {
                allowDiscards = true;
              };

              # content = {
              #   type = "btrfs";
              #   subvolumes = {
              #     "/run/media/hyena/Store" = {
              #       mountpoint = "/run/media/hyena/Store";
              #       mountOptions = [
              #         "compress=zstd"
              #         "subvol=store"
              #         "noatime"
              #         "nofail"
              #       ];
              #     };
              #   };
              # };

              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/run/media/hyena/Store";
                mountOptions = [
                  "nofail"
                  "exec"
                ];
                extraArgs = [ "-n" "Store" ];
              };

            };
          };
        };
      };
    };
  };
}
