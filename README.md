# Hyenas Nix Configs

These are my nix configs I use to manage my computers and servers.

Work in progress :)

## Host list

### Aardwolf (NixOS)

My desktop pc

### Possum (NixOS)

My home server

### VirtualLynx (NixOS)

Virtual Machine for testing

### Sabertooth (Darwin)

My MacBook

## Managing hosts

### Deploying a new host

TODO

### Adding Packages & Modules

TODO

### Updating Packages

To update a systems packages, navigate to the local configuration and run

```sh
nix flake update
```

to update the `flake.lock` and then run

```sh
sudo nixos-rebuild switch --flake . --upgrade
```

to switch the system to the new configuration while also upgrading packages.

### Darwin Hosts

TODO

## TODO

- Manage docker/podman containers with oci-containers
- Validation and deployment pipelines
- Support for multiple users

## Credits

- Notthebee - <https://github.com/notthebee/nix-config>
- IogaMaster - <https://github.com/IogaMaster/dotfiles>
- jakehamilton - <https://github.com/jakehamilton/config>
