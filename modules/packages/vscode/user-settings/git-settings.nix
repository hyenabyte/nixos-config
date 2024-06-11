{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.vscode.userSettings = {
    "git.autofetch" = true;
    "scm.defaultViewMode" = "tree";
  };
}
