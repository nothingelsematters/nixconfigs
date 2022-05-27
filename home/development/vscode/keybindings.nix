# Keybinings guide
#
# Defaults
#
# ⌘D      -- editor.action.addSelectionToNextFindMatch
# ⇧⌘\     -- editor.action.jumpToBracket
# f12     -- editor.action.revealDefinition
# ⌘K  f12 -- editor.action.revealDefinitionAside
# ⌘K  ⌘I  -- editor.action.showHover
# ⇧⌘P     -- workbench.action.showCommands
# ⌘P      -- workbench.action.quickOpen
# ⌘P :    -- go to line
#
# Custom
#
# ⇧f6     -- editor.action.changeAll
# ⌃G      -- extension.relativeGoto
# ⌃⇧T     -- workbench.action.terminal.toggleTerminal
#
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
    key = "ctrl+g";
    command = "extension.relativeGoto";
    when = "editorTextFocus";
  }
  {
    key = "ctrl+alt+g";
    command = "-extension.relativeGoto";
    when = "editorTextFocus";
  }
]
