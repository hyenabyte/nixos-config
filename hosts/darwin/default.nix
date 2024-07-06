{inputs, ...}: {
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

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.max-jobs = "auto";

  environment.systemPackages = [
    inputs.agenix.packages.aarch64-darwin.default
  ];
}
