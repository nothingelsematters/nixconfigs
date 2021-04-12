{ config, pkgs, ... }:

with config.lib; {
  "breadcrumbs.enabled" = true;
  "breadcrumbs.filePath" = "last";

  "editor.cursorBlinking" = "solid";
  "editor.cursorSmoothCaretAnimation" = false;
  "editor.cursorStyle" = "underline";

  "editor.fontFamily" = "'${theme.fonts.mono.name}'";
  "editor.fontLigatures" = true;
  "editor.fontSize" = 11.01;

  "editor.minimap.enabled" = false;
  "editor.renderWhitespace" = "none";
  "editor.formatOnSave" = true;
  "editor.rulers" = [ 120 ];
  "editor.smoothScrolling" = true;
  "editor.scrollBeyondLastLine" = false;
  "editor.multiCursorModifier" = "ctrlCmd";
  "editor.find.autoFindInSelection" = "new";

  "explorer.autoReveal" = true;
  "explorer.openEditors.visible" = 0;
  "explorer.confirmDelete" = false;
  "explorer.confirmDragAndDrop" = false;

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
  "terminal.integrated.fontSize" = 12;
  "terminal.explorerKind" = "external";
  "terminal.external.linuxExec" = config.lib.packages.terminal.name;

  "update.mode" = "none";

  "window.menuBarVisibility" = "toggle";
  "window.title" = "\${dirty}  \${rootName}\${separator}\${activeEditorMedium}";
  "window.titleBarStyle" = "native";
  "window.zoomLevel" = -1;

  "workbench.colorTheme" = "Github Dark";
  "workbench.editor.enablePreviewFromQuickOpen" = false;
  "workbench.iconTheme" = "file-icons";
  "workbench.settings.enableNaturalLanguageSearch" = false;
  "workbench.startupEditor" = "none";
  "workbench.activityBar.visible" = true;
  "workbench.statusBar.visible" = true;
  "workbench.tips.enabled" = false;
  "workbench.tree.indent" = 18;
  "workbench.tree.renderIndentGuides" = "always";
  "workbench.panel.defaultLocation" = "right";

  "zenMode.centerLayout" = false;
  "zenMode.fullScreen" = false;
  "zenMode.hideLineNumbers" = false;
  "zenMode.hideStatusBar" = false;

  "files.maxMemoryForLargeFilesMB" = 1024;

  "todo-tree.tree.showScanModeButton" = false;

  "gitmoji.outputType" = "code";

  # rust
  "[rust]"."editor.defaultFormatter" = "rust-lang.rust";

  # nix
  "[nix]" = {
    "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
    "editor.tabSize" = 2;
    "editor.rulers" = [ 80 ];
  };
  "nixfmt.path" = pkgs.nixfmt + /bin/nixfmt;

  # sql
  "[sql]" = {
    "editor.tabSize" = 2;
    "editor.rulers" = [ 80 ];
  };

  # haskell
  "[haskell]" = {
    "editor.defaultFormatter" = "vigoo.stylish-haskell";
    "editor.tabSize" = 2;
    "editor.rulers" = [ 80 ];
  };

  # python
  "python.dataScience.alwaysTrustNotebooks" = true;
  "python.dataScience.askForKernelRestart" = false;
  "jupyter.experiments.optInfo" = [ "CustomEditor" ];
  "jupyter.askForKernelRestart" = false;

  # latex
  "[latex]"."editor.wordWrap" = "on";
}
