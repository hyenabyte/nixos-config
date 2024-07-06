{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      inputs.nur.overlay
    ];
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.settings.max-jobs = "auto";

  programs.zsh.enable = true;

  environment.systemPackages = [
    pkgs.vim
    pkgs.git

    inputs.agenix.packages.x86_64-linux.default
  ];
}
