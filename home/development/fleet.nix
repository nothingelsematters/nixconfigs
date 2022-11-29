{
  home.file.fleet = {
    target = ".fleet/settings.json";
    text = builtins.toJSON {
      # General
      "theme" = "sync-with-os";
      "zoomLevel" = 1.0;
      "keymap" = "macos-vscode";
      "restoreWorkspacesOnStartup" = false;

      # Editor: Font
      "editor.fontFamily" = "JetBrains Mono";
      "editor.fontSize" = 12.01;
      "editor.lineSpacing" = 1.7;

      # Editor: Appearence
      "editor.caretShape" = "Underline";
      "editor.showVisualGuides" = true;
      "editor.guides" = [ 120 ];
      "editor.softWrapEnabled" = true;
      "editor.tabLimit" = 15;

      # Editor: Code
      "editor.tabSize" = 4;
      "editor.showCodeVision" = true;

      # Files
      "files.toggleFolderMode" = "singleClick";

      # Git
      "git.autoFetch" = false;

      # Terminal
      "terminal.fontSize" = 12.01;
      "terminal.lineSpacing" = 1.3;

      # Accessibility
      "editor.caretBlinkingEnabled" = false;

      # Data Sharing
      "fus.sendAllowed" = false;
    };
  };
}
