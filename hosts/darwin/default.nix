{inputs, ...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.max-jobs = "auto";

  environment.systemPackages = [
    inputs.agenix.packages.aarch64-darwin.default
  ];
}
