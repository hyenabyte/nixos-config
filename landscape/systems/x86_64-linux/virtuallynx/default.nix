{...}: {
  # Virtual Machine Testing Platform

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
  ];

  # ! DO NOT CHANGE !
  system.stateVersion = "24.05";
}
