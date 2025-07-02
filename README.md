# Hyenas Nix Configs

> [!IMPORTANT]
> The Github version of my configs has been archived as of 2025-07-02,
> find my up to date configs here: https://codeberg.org/hyenabyte/nixos-config

These are my nix configs I use to manage my computers and servers.

Work in progress :)

## Host list

| Hostname      | OS     | System         | Description                      |
| ------------- | ------ | -------------- | -------------------------------- |
| culpeo        | NixOS  | x86_64-linux   | My Work Laptop                   |
| sabertooth    | MacOS  | aarch64-darwin | My Macbook Pro                   |
| aardwolf      | NixOS  | x86_64-linux   | My Desktop PC                    |
| ferret        | NixOS  | x86_64-linux   | My aya neo, currently not in use |
| possum        | NixOS  | x86_64-linux   | My Home Server                   |
| lynx          | NixOS  | x86_64-vm      | A testing virtual machine        |


## Managing hosts

### Deploying a new host

TODO

### Adding Packages & Modules

TODO

### Updating Packages

To update systems packages, navigate to the local configuration and run

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

[See TODO.md](/TODO.md)

## Credits

- Notthebee - <https://github.com/notthebee/nix-config>
- IogaMaster - <https://github.com/IogaMaster/dotfiles>
- jakehamilton - <https://github.com/jakehamilton/config>
