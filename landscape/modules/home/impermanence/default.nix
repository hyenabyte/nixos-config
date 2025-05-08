{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.impermanence;
in
{
  options.${namespace}.impermanence = {
    enable = mkEnableOption "impermanence";
    user = mkOpt types.str "hyena" "The username";
  };
  config = mkIf cfg.enable {
    home.persistence."/persist/home/${cfg.user}" = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "Workspace"
        ".gnupg"
        ".nixops"
        ".local/share/keyrings"
        ".local/share/direnv"
        ".ssh"
        # {
        #   directory = ".local/share/Steam";
        #   method = "symlink";
        # }
      ];

      files = [
        ".screenrc"
      ];

      # Allow other users, such as root, to access files
      allowOther = true;
    };
  };
}
