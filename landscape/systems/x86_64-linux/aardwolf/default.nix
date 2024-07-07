{...}: {
  # My Desktop PC

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
  ];

  # ! DO NOT CHANGE !
  system.stateVersion = "23.11";
}
