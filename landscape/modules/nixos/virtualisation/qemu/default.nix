{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.virtualisation.qemu;
in {
  options.${namespace}.virtualisation.qemu = {enable = mkEnableOption "qemu";};
  config = mkIf cfg.enable {
    # Credit to TechSupportOnHold for this
    # https://github.com/TechsupportOnHold/Nixos-VM

    # Enable dconf (System Management Tool)
    programs.dconf.enable = true;

    # Add user to libvirtd group
    users.users.${config.${namespace}.user.name}.extraGroups = ["libvirtd"];

    # Install necessary packages
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      adwaita-icon-theme
    ];

    # Manage the virtualisation services
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [pkgs.OVMFFull.fd];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}