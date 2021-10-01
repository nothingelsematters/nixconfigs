[
  {
    command = "editor.action.changeAll";
    key = "shift+f6";
    when = "editorTextFocus && editorTextFocus && !editorReadonly";
  }
  {
    command = "-editor.action.changeAll";
    key = "ctrl+f2";
    when = "editorTextFocus && editorTextFocus && !editorReadonly";
  }
  {
    command = "markdown.showPreview";
    key = "ctrl+shift+m";
    when = "editorLangId == 'markdown'";
  }
  {
    command = "-markdown.showPreview";
    key = "ctrl+shift+v";
    when = "editorLangId == 'markdown'";
  }
  {
    command = "workbench.action.reloadWindow";
    key = "ctrl+f5";
  }
  {
    command = "workbench.action.terminal.toggleTerminal";
    key = "ctrl+shift+t";
  }
  {
    command = "workbench.action.closeSidebar";
    key = "ctrl+shift+q";
  }
]
