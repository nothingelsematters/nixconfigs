- [Alias/Usage guides](#aliasusage-guides)
  - [git](#git)
  - [gh](#gh)
- [Keybinding guides](#keybinding-guides)
  - [ZSH](#zsh)
  - [VS Code](#vs-code)
  - [Intellij IDEA](#intellij-idea)


# Alias/Usage guides

## [git](development/git/)

| alias              | command                  |
| :----------------- | :----------------------- |
| `g.cl`             | clone                    |
| `g.pull`           | pull                     |
| `g.push`           | push                     |
| `g.s`              | status                   |
| `g.a`              | forgit::add              |
| `g.c.m <message>`  | commit                   |
| `g.c.m! <message>` | commit no-verify         |
| `g.co`             | checkout                 |
| `g.co.b`           | forgit::checkout::branch |
| `g.r`              | rebase                   |
| `g.r.m.pull`       | pull main + rebase main  |
| `g.l`              | forgit::log              |

## gh

Useful commands:

- `gh pr create --title "..." --label minor --reviewer ...`
- `gh pr checks`
- `gh pr view --comments`
- `gh pr view --web`

# Keybinding guides

## [ZSH](teminal/zsh/)

| keybinding | action                                         |
| :--------- | :--------------------------------------------- |
| **custom** |                                                |
| ⌃ H        | history search ([[atuin]](terminal/atuin.nix)) |
| ⌃ F        | file search ([[fzf]](terminal/fzf.nix))        |

## [VS Code](development/vscode/)

| keybinding   | action                                      |
| :----------- | :------------------------------------------ |
| **defaults** |                                             |
| ⌘ D          | `editor.action.addSelectionToNextFindMatch` |
| ⇧ ⌘ \        | `editor.action.jumpToBracket`               |
| f12          | `editor.action.revealDefinition`            |
| ⌘ K,  f12    | `editor.action.revealDefinitionAside`       |
| ⌘ K,  ⌘I     | `editor.action.showHover`                   |
| ⌘ P          | `workbench.action.quickOpen`                |
| ⌘ P, :       | `go to line`                                |
| ⇧ ⌘ P        | `workbench.action.showCommands`             |
| **custom**   |                                             |
| ⇧ f6         | `editor.action.changeAll`                   |
| ⌃ G          | `extension.relativeGoto`                    |
| ⌃ ⇧ T        | `workbench.action.terminal.toggleTerminal`  |


## Intellij IDEA

| keybinding    | action                                            |
| :------------ | :------------------------------------------------ |
| ⌥ + ⌥ up/down | Add carets above/below                            |
| ⌃ G           | Add carets, select multiple occurrences of a word |
| ⌃ J           | Quick documentation pop up                        |
