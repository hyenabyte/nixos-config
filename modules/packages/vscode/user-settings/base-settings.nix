{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.base-settings;
in {
  options.base-settings = {enable = mkEnableOption "base-settings";};
  config = mkIf cfg.enable {
    programs.vscode.userSettings = {
      # Font settings
      "editor.fontSize" = 16;
      "editor.fontFamily" = "'Agave Nerd Font Mono', 'ComicShannsMono Nerd Font', 'Iosevka Term SS01 extended', 'Iosevka Nerd Font Mono', 'Fira Code', 'Source Code Pro'"; #'Iosevka Term SS01 Extended', 'Fira Code', 'Cascadia Code', 'Source Code Pro', 'monospace', monospace, 'Droid Sans Fallback'
      "editor.fontLigatures" = true;
      "editor.lineHeight" = 30;

      # Layout
      "editor.padding.top" = 20;
      "editor.padding.bottom" = 20;
      "workbench.editor.wrapTabs" = true;
      "workbench.sideBar.location" = "right";

      # Formatting
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";

      # Look and feel
      "editor.smoothScrolling" = true;
      "editor.stickyTabStops" = true;
      "editor.find.addExtraSpaceOnTop" = false;
      "editor.minimap.renderCharacters" = false;
      "editor.minimap.maxColumn" = 75;
      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = "active";
      "workbench.list.smoothScrolling" = true;
      "workbench.editor.decorations.colors" = true;

      # Cursor
      "editor.cursorBlinking" = "phase";
      "editor.cursorSmoothCaretAnimation" = "on";

      # Suggestions
      "editor.inlineSuggest.enabled" = true;
      "editor.quickSuggestions" = {
        "strings" = true;
      };

      # Files
      "files.eol" = "\n";
      "files.associations" = {
        "*.html" = "html";
        "*.tera" = "twig";
        "*.svelte" = "svelte";
      };
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;

      # Terminal
      "terminal.integrated.cursorStyle" = "underline";
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.fontFamily" = "'Agave Nerd Font Mono','Iosevka Nerd Font Mono',  'Fira Mono Light', 'Source Code Pro', 'monospace'";
      "terminal.external.osxExec" = "Alacritty.app";
      "terminal.integrated.fontSize" = 15;
      "terminal.integrated.tabs.location" = "left";

      # Other
      "editor.renderFinalNewline" = "off";
      "editor.renderLineHighlight" = "all";
      "editor.renderLineHighlightOnlyWhenFocus" = true;
      "editor.find.autoFindInSelection" = "multiline";
      "editor.linkedEditing" = true;
      "editor.accessibilitySupport" = "off";
      "workbench.enableExperiments" = false;
      "workbench.editor.closeOnFileDelete" = true;
      "window.commandCenter" = true;
      "explorer.incrementalNaming" = "smart";
      "keyboard.dispatch" = "keyCode";
      "git.autofetch" = true;
    };
  };
}
