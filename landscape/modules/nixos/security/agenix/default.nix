{ pkgs
, lib
, config
, inputs
, namespace
, system
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.agenix;
in
{
  options.${namespace}.security.agenix = with types; {
    enable = mkEnableOption "Agenix";
    sshKey = mkOpt str "/home/hyena/.ssh/id_ed25519" "The path to the SSH key";
    secrets = mkOpt attrs { } "Secrets";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.age
      inputs.agenix.packages.${system}.default
    ];

    age.identityPaths = [
      cfg.sshKey
    ];

    # TODO: maybe find a way to map strings to paths instead of
    # having to reference the input for each config

    age.secrets = {
      hashedUserPassword.file = inputs.secrets.outPath + "/hashedUserPassword.age";
    } // cfg.secrets;
  };
}
