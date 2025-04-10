{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.security.keyring.kwallet;
in
{
  options.${namespace}.security.keyring.kwallet = with types; {
    enable = mkEnableOption "kwallet";
    enableGreetd = mkOpt bool false "Unlock kwallet on greetd login";
    users = mkOpt (listOf str) [ ] "The user to enable the keyring for";
  };
  config = mkIf cfg.enable {
    security.pam = {
      services =
        let
          mappedUsers = builtins.listToAttrs
            (map
              (v: {
                name = v;
                value = {
                  kwallet = {
                    enable = true;
                    package = pkgs.kdePackages.kwallet-pam;
                  };
                };
              })
              cfg.users);
        in
        {
          greetd = mkIf cfg.enableGreetd {
            enableKwallet = true;
          };
        }
        // mappedUsers;
    };
  };
}
