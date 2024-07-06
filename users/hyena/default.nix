{
  config,
  pkgs,
  inputs,
  self,
  ...
}: let
  username = "hyena";
  ssh-keys = (import "${self}/lib/" inputs).formatSSHKeys inputs.ssh-keys.outPath;
in {
  nix.settings.trusted-users = [username];

  users = {
    users = {
      ${username} = {
        description = "${username}'s user";
        shell = pkgs.zsh;
        uid = 1000;
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets.hashedUserPassword.path;
        extraGroups = [
          "wheel"
          "users"
          "podman"
          "networkmanager"
        ];
        group = username;
        openssh.authorizedKeys.keys = ssh-keys.keys;
      };
    };
    groups = {
      ${username} = {
        gid = 1000;
      };
    };
  };
  programs.zsh.enable = true;
}
