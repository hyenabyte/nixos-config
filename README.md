# Hyenas Nix Configs

These are my nix configs I use to manage my computers and servers.

Work in progress :)

## Host list

| Hostname      | OS     | System         | Description                      |
| ------------- | ------ | -------------- | -------------------------------- |
| sabertooth    | MacOS  | aarch64-darwin | My Macbook Pro                   |
| sabertoothnix | NixOS  | aarch64-linux  | Asahi Linux on my Macbook Pro    |
| aardwolf      | NixOS  | x86_64-linux   | My Desktop PC                    |
| badger        | NixOS  | x86_64-linux   | Currently not in service         |
| ferret        | NixOS  | x86_64-linux   | My aya neo, currently not in use |
| possum        | NixOS  | x86_64-linux   | My Home Server                   |
| weasel        | NixOS  | x86_64-linux   | A Contabo VPS                    |
| lynx          | NixOS  | x86_64-vm      | A testing virtual machine        |


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

or

```sh
flake update
```

to update the `flake.lock` and then run

```sh
sudo nixos-rebuild switch --flake . --upgrade
```

or

```sh
flake switch
```

to switch the system to the new configuration while also upgrading packages.

### Darwin Hosts

See <https://github.com/LnL7/nix-darwin>

## TODO

- Manage docker/podman containers with oci-containers
- Validation and deployment pipelines
- Support for multiple users

## Credits

- Notthebee - <https://github.com/notthebee/nix-config>
- IogaMaster - <https://github.com/IogaMaster/dotfiles>
- jakehamilton - <https://github.com/jakehamilton/config>
