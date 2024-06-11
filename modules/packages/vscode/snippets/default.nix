{...}: {
  imports = [
    ./typescript.nix
    ./astro.nix
    ./nix.nix
  ];

  modules = {
    astro-snippets.enable = true;
    typescript-snippets.enable = true;
    nix-snippets.enable = true;
  };
}
