{pkgs, ...}: {
  nix.settings.trusted-users = ["hyena"];

  # age.identityPaths = [
  #   "/home/notthebee/.ssh/notthebee"
  #   "/home/notthebee/.ssh/id_ed25519"
  # ];

  # age.secrets.hashedUserPassword = {
  #   file = ../../secrets/hashedUserPassword.age;
  # };

  users = {
    users = {
      hyena = {
        description = "hyena";
        shell = pkgs.zsh;
        uid = 1000;
        isNormalUser = true;
        # hashedPasswordFile = config.age.secrets.hashedUserPassword.path;
        extraGroups = [
          "wheel"
          "users"
          "podman"
          "networkmanager"
        ];
        group = "hyena";
        # openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKGUGMUo1dRl9xoDlMxQGb8dNSY+6xiEpbZWAu6FAbWw moe@notthebe.ee"];
      };
    };
    groups = {
      hyena = {
        gid = 1000;
      };
    };
  };
  programs.zsh.enable = true;
}
