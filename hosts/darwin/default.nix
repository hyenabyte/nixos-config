{
  inputs,
  pkgs,
  lib,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.max-jobs = "auto";
}
