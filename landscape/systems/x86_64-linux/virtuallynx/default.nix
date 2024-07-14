{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  # Virtual Machine Testing Platform

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
  ];

  ${namespace} = {
    suites.common = enabled;
    system.boot.efi.enable = mkForce false;
    system.boot.grub = {
      enable = true;
      device = "/dev/vda";
    };
    services.openssh = enabled;
    cli.lazygit = enabled;
  };

  # ! DO NOT CHANGE !
  system.stateVersion = "24.05";
}
