{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.vscode.userSettings = {
    "terminal.integrated.cursorStyle" = "underline";
    "terminal.integrated.cursorBlinking" = true;
    "terminal.integrated.fontFamily" = "'Agave Nerd Font Mono','Iosevka Nerd Font Mono',  'Fira Mono Light', 'Source Code Pro', 'monospace'";
    "terminal.external.osxExec" = "Alacritty.app";
    "terminal.integrated.fontSize" = 15;
    "terminal.integrated.tabs.location" = "left";
  };
}
