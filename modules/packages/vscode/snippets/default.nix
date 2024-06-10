{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./typescript.nix
    ./astro.nix
  ];

  astro-snippets.enable = true;
  typescript-snippets.enable = true;
}
