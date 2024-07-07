{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.git;
  # gpg = config.${namespace}.security.gpg;
  user = config.${namespace}.user;
in {
  options.${namespace}.tools.git = with types; {
    enable = mkEnableOption "Enable git";
    userName = mkOpt str user.fullName "User full name for git configuration.";
    userEmail = mkOpt str user.email "User email for git configuration";
    # signingKey =
    #   mkOpt str "" "The key ID to sign commits with.";
  };
  config = mkIf cfg.enable {
    ${namespace}.home.programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;

      # lfs = enabled;
      # signing = {
      #   key = cfg.signingKey;
      #   signByDefault = mkIf gpg.enable true;
      # };

      extraConfig = {
        init = {defaultBranch = "main";};
        pull = {rebase = true;};
        push = {autoSetupRemote = true;};
        core = {
          excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
        };
      };
    };
  };
}
