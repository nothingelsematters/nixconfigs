- [Alias/Usage guides](#aliasusage-guides)
  - [git](#git)
  - [gh](#gh)
- [Keybinding guides](#keybinding-guides)
  - [Kitty](#kitty)
  - [ZSH](#zsh)
  - [VS Code](#vs-code)
  - [Intellij IDEA](#intellij-idea)
  - [Arc](#arc)


# Alias/Usage guides

## [git](development/git/)

| alias             | command                  |
| :---------------- | :----------------------- |
| `g.cl`            | clone                    |
| `g.pull`          | pull                     |
| `g.push`          | push                     |
| `g.s`             | status                   |
| `g.a`             | forgit::add              |
| `g.c.m <message>` | commit                   |
| `g.co`            | checkout                 |
| `g.co.b`          | forgit::checkout::branch |
| `g.r`             | rebase                   |
| `g.r.m.pull`      | pull main + rebase main  |
| `g.l`             | forgit::log              |

## gh

Useful commands:

- `gh pr create --title "..." --label minor --reviewer ...`
- `gh pr checks`
- `gh pr view --comments`
- `gh pr view --web`

# Keybinding guides

## [Kitty](terminal/kitty/)

[[reference]](https://sw.kovidgoyal.net/kitty/conf/)

| keybinding         | action                      |
| :----------------- | :-------------------------- |
| **defaults**       |                             |
| ⌘ page_up (fn ↑)   | scroll_page_up              |
| ⌘ page_down (fn ↓) | scroll_page_down            |
| ⌃ ⇧ g              | browse last output in pager |
| **tab management** |                             |
| ⌘ t                | new_tab                     |
| ⌘ w                | close_tab                   |
| ⌃ ⇥ // ⌃ ⇧ ⇥       | next_tab / previous_tab     |
| ⇧ ⌘ ] // [         |                             |
| ⌃ ⇧ ← // →         |                             |
| ⇧ ⌘ i              | set_tab_title               |
| ⌃ ⇧ . // ,         | move_tab_forward / backward |
| **custom**         |                             |
| ⌘ {1-9}            | goto_tab {1-9}              |

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


## Arc

[[reference]](https://arc.net/)

| keybinding | action                             |
| :--------- | :--------------------------------- |
| **window** |                                    |
| ⌘ Y        | View History                       |
| ⌘ S        | Show/Hide Sidebar                  |
| ⇧ ⌘ D      | Show/Hide Toolbar                  |
| ⌥ ⌘ N      | Open Little Arc (for quick search) |
| ⌃ ⇧ =      | Add Split View                     |
| **tab**    |                                    |
| ⌘ D        | Pin/Unpin Tab                      |
| ⌥ ⌘ V      | Paste as New Tab                   |
| ⇧ ⌘ R      | Force Refresh the Page             |
