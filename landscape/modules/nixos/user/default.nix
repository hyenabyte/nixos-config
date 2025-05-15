# Inspired by jakehamiltons fine work
# https://github.com/jakehamilton/config/blob/main/modules/nixos/user/default.nix
{ pkgs
, lib
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.user;

  fallbackPasswordHash = "$y$j9T$WTT3f4PsCXRrl7qIbjNrq0$vj7SUfe1j88Q5PbnR802j83bCBMixdjUCsut/YJBcz0";

  defaultIconFileName = "profile.png";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";

    dontUnpack = true;

    installPhase = ''
      cp $src $out
    '';

    passthru = { fileName = defaultIconFileName; };
  };
  propagatedIcon =
    pkgs.runCommandNoCC "propagated-icon"
      { passthru = { fileName = cfg.icon.fileName; }; }
      ''
        local target="$out/share/${namespace}-icons/user/${cfg.name}"
        mkdir -p "$target"

        cp ${cfg.icon} "$target/${cfg.icon.fileName}"
      '';
in
{
  options.${namespace}.user = with types; {
    name = mkOpt str "hyena" "The username for the account.";
    fullName = mkOpt str "hyena" "The full name for the account.";
    email = mkOpt str "hyena@hyenabyte.dev" "The email address for the account.";
    icon = mkOpt (nullOr package) defaultIcon "The profile picture for the account.";
    extraGroups = mkOpt (listOf str) [ ] "Groups the user is assigned to.";
    extraOptions = mkOpt attrs { } "Extra options for the user";
  };
  config = {
    environment.systemPackages = [
      propagatedIcon
    ];

    programs.zsh.enable = true;

    ${namespace}.home = {
      file = {
        "Documents/.keep".text = "";
        "Downloads/.keep".text = "";
        "Music/.keep".text = "";
        "Pictures/.keep".text = "";
        "Videos/.keep".text = "";
        "Workspace/.keep".text = "";
        ".face".source = cfg.icon;
        "Pictures/${
          cfg.icon.fileName or (builtins.baseNameOf cfg.icon)
        }".source =
          cfg.icon;
      };
    };

    users.users.${cfg.name} =
      {
        name = cfg.name;
        description = cfg.fullName;
        isNormalUser = true;
        home = "/home/${cfg.name}";

        # Set shell to be zsh
        shell = pkgs.zsh;

        uid = 1000;

        # Get hashed password file from secrets storage
        hashedPasswordFile = lib.mkIf (builtins.hasAttr "hashedUserPassword" config.age.secrets) config.age.secrets.hashedUserPassword.path;
        hashedPassword = mkUnless (builtins.hasAttr "hashedUserPassword" config.age.secrets) fallbackPasswordHash;

        extraGroups =
          [
            "wheel"
            "users"
            "networkmanager"
          ]
          ++ cfg.extraGroups;
        group = cfg.name;

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILB9h2AvSBpvHQEcHuXsQPmrHzdezyo6MvzYd1oKTI7n hyena@possum"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPZV6QOMqWhyV/dXVliNRtZIZUmAr2gRTEqAnIisOw1t hyena@aardwolf"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID73x+vjeI5+mE+mqhs4qGVTSpmg9z0gEtHUPySKUhOq hyena@sabertooth"
        ];
      }
      // cfg.extraOptions;

    users.groups = {
      ${cfg.name} = {
        gid = 1000;
      };
    };

    users.users.root.hashedPasswordFile = lib.mkIf (builtins.hasAttr "hashedUserPassword" config.age.secrets) config.age.secrets.hashedUserPassword.path;
    users.users.root.hashedPassword = mkUnless (builtins.hasAttr "hashedUserPassword" config.age.secrets) fallbackPasswordHash;

    users.mutableUsers = false;
  };
}
