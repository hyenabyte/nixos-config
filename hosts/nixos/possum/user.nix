{pkgs, ...}: {
  config = {
    home.stateVersion = "23.11";

    # Modules
    modules = {
    };

    # Packages
    home.packages = with pkgs; [
    ];
  };
}
