{ config, pkgs, ... }:

with config.lib; {
  "breadcrumbs.enabled" = true;

  "editor.cursorBlinking" = "solid";
  "editor.cursorSmoothCaretAnimation" = false;
  "editor.cursorStyle" = "underline";
  "editor.fontFamily" = "'${theme.fonts.mono.name}'";
  "editor.fontLigatures" = true;
  "editor.minimap.enabled" = false;
  "editor.minimap.maxColumn" = 200;
  "editor.minimap.renderCharacters" = false;
  "editor.minimap.showSlider" = "always";
  "editor.minimap.size" = "fit";
  "editor.renderWhitespace" = "none";
  "editor.formatOnSave" = true;
  "editor.rulers" = [ 80 ];
  "editor.smoothScrolling" = true;
  "editor.find.autoFindInSelection" = "always";
  "editor.fontSize" = 10;
  "editor.scrollBeyondLastLine" = false;
  "editor.multiCursorModifier" = "ctrlCmd";

  "explorer.autoReveal" = true;
  "explorer.openEditors.visible" = 0;

  "extensions.ignoreRecommendations" = true;
  "extensions.showRecommendationsOnlyOnDemand" = true;

  "files.autoSave" = "onFocusChange";
  "files.exclude"."**/.git" = true;
  "files.insertFinalNewline" = true;
  "files.trimTrailingWhitespace" = true;
  "files.watcherExclude" = {
    "**/.git/objects/**" = true;
    "**/.git/subtree-cache/**" = true;
    "**/node_modules/**" = true;
  };

  "telemetry.enableCrashReporter" = false;
  "telemetry.enableTelemetry" = false;

  "terminal.integrated.cursorBlinking" = false;
  "terminal.integrated.cursorStyle" = "underline";
  "terminal.integrated.fontFamily" = theme.fonts.mono.name;
  "terminal.integrated.fontSize" = 10;
  "terminal.explorerKind" = "external";
  "terminal.external.linuxExec" = "kitty";

  "update.mode" = "none";

  "window.menuBarVisibility" = "toggle";
  "window.title" = "\${dirty} \${activeEditorMedium}\${separator}\${rootName}";
  "window.titleBarStyle" = "native";

  "workbench.colorTheme" = "Material Theme Palenight High Contrast";
  "workbench.editor.enablePreviewFromQuickOpen" = false;
  "workbench.iconTheme" = "file-icons";
  "workbench.settings.enableNaturalLanguageSearch" = false;
  "workbench.startupEditor" = "none";
  "workbench.activityBar.visible" = true;
  "workbench.statusBar.visible" = true;
  "workbench.tips.enabled" = false;
  "workbench.tree.indent" = 18;

  "zenMode.centerLayout" = false;
  "zenMode.fullScreen" = false;
  "zenMode.hideLineNumbers" = false;
  "zenMode.hideStatusBar" = false;

  "files.maxMemoryForLargeFilesMB" = 1024;

  "todo-tree.tree.showScanModeButton" = false;

  # haskell
  "languageServerHaskell.hlintOn" = true;
  "languageServerHaskell.maxNumberOfProblems" = 100;
  "languageServerHaskell.formattingProvider" = "none";
  "[haskell]" = {
    "editor.defaultFormatter" = "vigoo.stylish-haskell";
    "editor.tabSize" = 2;
  };
  "haskell.hlint.executablePath" = pkgs.hlint + /bin/hlint;
  "haskell.hlint.run" = "onType";
  "ghcSimple.startupCommands.all" = [
    "System.IO.hSetBuffering System.IO.stderr System.IO.NoBuffering"
    "System.IO.hSetBuffering System.IO.stdout System.IO.NoBuffering"
    ":set -haddock"
  ];
  "stylishHaskell.commandLine" = "${pkgs.stylish-haskell}/bin/stylish-haskell"
    + " -c $HOME/university/functional-programming"
    + "/functional-programming-course/.stylish-haskell.yaml";

  # nix
  "[nix]" = {
    "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
    "editor.tabSize" = 2;
  };
  "nixfmt.path" = pkgs.nixfmt + /bin/nixfmt;
}
