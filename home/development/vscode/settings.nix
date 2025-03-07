{ config, ... }:

with config.lib;
{
  "breadcrumbs.enabled" = true;
  "breadcrumbs.filePath" = "last";

  "editor.cursorBlinking" = "solid";
  "editor.cursorSmoothCaretAnimation" = "off";
  "editor.cursorStyle" = "underline";
  "editor.cursorSurroundingLines" = 10;
  "editor.lineNumbers" = "relative";

  "editor.fontFamily" = "'${fonts.mono.name}'";
  "editor.fontLigatures" = true;
  "editor.fontSize" = 12.01;

  "editor.minimap.enabled" = false;
  "editor.renderWhitespace" = "none";
  "editor.formatOnSave" = true;
  "editor.rulers" = [ 120 ];
  "editor.smoothScrolling" = true;
  "editor.scrollBeyondLastLine" = false;
  "editor.stickyScroll.enabled" = true;
  "editor.multiCursorModifier" = "ctrlCmd";
  "editor.find.autoFindInSelection" = "never";
  "editor.suggest.preview" = true;

  "explorer.autoReveal" = true;
  "explorer.confirmDelete" = false;
  "explorer.confirmDragAndDrop" = false;

  "extensions.ignoreRecommendations" = true;
  "extensions.autoUpdate" = false;

  "files.autoSave" = "onFocusChange";
  "files.exclude"."**/.git" = true;
  "files.insertFinalNewline" = true;
  "files.trimTrailingWhitespace" = true;
  "files.watcherExclude" = {
    "**/.git/objects/**" = true;
    "**/.git/subtree-cache/**" = true;
    "**/node_modules/**" = true;
  };

  "telemetry.telemetryLevel" = "off";

  "terminal.integrated.cursorBlinking" = false;
  "terminal.integrated.cursorStyle" = "underline";
  "terminal.integrated.fontFamily" = fonts.mono.name;
  "terminal.integrated.fontSize" = 12.01;
  "terminal.integrated.stickyScroll.enabled" = true;
  "terminal.explorerKind" = "external";

  "update.mode" = "none";

  "window.title" = "\${dirty}  \${rootName}\${separator}\${activeEditorMedium}";
  "window.titleBarStyle" = "custom";
  "window.commandCenter" = true;
  "window.autoDetectColorScheme" = true;
  "window.newWindowDimensions" = "offset";

  "workbench.colorTheme" = "GitHub Light";
  "workbench.preferredLightColorTheme" = "GitHub Light";
  "workbench.preferredDarkColorTheme" = "GitHub Dark";
  "workbench.editor.enablePreviewFromQuickOpen" = false;
  "workbench.iconTheme" = "file-icons";
  "workbench.settings.enableNaturalLanguageSearch" = false;
  "workbench.startupEditor" = "none";
  "workbench.statusBar.visible" = true;
  "workbench.tips.enabled" = false;
  "workbench.tree.indent" = 18;
  "workbench.tree.renderIndentGuides" = "always";
  "workbench.panel.defaultLocation" = "right";
  "workbench.layoutControl.enabled" = false;

  "zenMode.centerLayout" = false;
  "zenMode.fullScreen" = false;
  "zenMode.hideLineNumbers" = false;
  "zenMode.hideStatusBar" = false;

  "[markdown]" = {
    "editor.wordWrap" = "bounded";
    "editor.wordWrapColumn" = 1000;
  };

  # usernamehw.errorlens extension
  "errorLens.gutterIconsEnabled" = true;
}
