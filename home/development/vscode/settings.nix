{ config, pkgs, ... }:

with config.lib; {
  "breadcrumbs.enabled" = true;
  "breadcrumbs.filePath" = "last";

  "editor.cursorBlinking" = "solid";
  "editor.cursorSmoothCaretAnimation" = false;
  "editor.cursorStyle" = "underline";

  "editor.fontFamily" = "'${theme.fonts.mono.name}'";
  "editor.fontLigatures" = true;
  "editor.fontSize" = 12.01;

  "editor.minimap.enabled" = false;
  "editor.renderWhitespace" = "none";
  "editor.formatOnSave" = true;
  "editor.rulers" = [ 120 ];
  "editor.smoothScrolling" = true;
  "editor.scrollBeyondLastLine" = false;
  "editor.multiCursorModifier" = "ctrlCmd";
  "editor.find.autoFindInSelection" = "never";

  "explorer.autoReveal" = true;
  "explorer.openEditors.visible" = 0;
  "explorer.confirmDelete" = false;
  "explorer.confirmDragAndDrop" = false;

  "extensions.ignoreRecommendations" = true;

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
  "terminal.integrated.fontFamily" = "JetBrains Mono";
  "terminal.integrated.fontSize" = 10;
  "terminal.explorerKind" = "external";

  "update.mode" = "none";

  "window.menuBarVisibility" = "toggle";
  "window.title" = "\${dirty}  \${rootName}\${separator}\${activeEditorMedium}";
  "window.titleBarStyle" = "native";

  "workbench.colorTheme" = "GitHub Dark";
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

  # sql
  "[sql]" = {
    "editor.tabSize" = 2;
    "editor.rulers" = [ 80 ];
  };
}
