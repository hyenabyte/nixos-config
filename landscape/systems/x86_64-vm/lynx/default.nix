{ lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; {
  ${namespace} = {
    services.openssh = enabled;

    desktop = {
      dm.greetd = enabled;
      hyprland = enabled;
    };

    suites = {
      common = enabled;
    };
  };
  users.users.hyena.initialHashedPassword = "$y$j9T$ojplgKgjZeRZuUfSuNZ2V1$udv9DasvG0S65D0nDLSkIMc0E5E0VmM6M6SD/EMUQxB";
  users.users.root.initialHashedPassword = "$y$j9T$ojplgKgjZeRZuUfSuNZ2V1$udv9DasvG0S65D0nDLSkIMc0E5E0VmM6M6SD/EMUQxB";

  # ! DO NOT CHANGE !
  system.stateVersion = "24.05";
}
