{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./bluetooth
    ./budgie
    ./caddy
    ./cinnamon
    ./firewall
    ./fonts
    ./gnome
    ./jellyfin
    ./locale
    ./nix-ld
    ./nvidia
    ./pantheon
    ./pipewire
    ./plasma
    ./podman
    ./samba
    ./ssh
    ./tailscale
    ./virtual-box
  ];
}
