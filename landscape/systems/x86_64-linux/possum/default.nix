{...}: {
  # Thinkcentre Server

  imports = [
    # System hardware configuration
    ./hardware-configuration.nix
  ];

  # ! DO NOT CHANGE !
  system.stateVersion = "22.11";
}
