<p align="center"><img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo.svg" width=512></p>

<p align="center">
    <a href="https://github.com/nothingelsematters">
        <img src="https://img.shields.io/github/commit-activity/y/nothingelsematters/nixconfigs?style=flat-square&logo=github">
    </a>
    <a href="https://nixos.org">
        <img src="https://img.shields.io/badge/generations-334-green?style=flat-square&logo=nixos">
    </a>
    <a href="https://www.codefactor.io/repository/github/nothingelsematters/nixconfigs">
        <img src="https://img.shields.io/codefactor/grade/github/nothingelsematters/nixconfigs?style=flat-square&logo=codefactor">
    </a>
</p>

<h1 align="center"> custom <a href="https://nixos.org">NixOS</a> configuration </h1>

## Nix tools being used

- [Niv](https://github.com/nmattia/niv) - Easy dependency management for Nix project: [generated `source.json` file](nix/sources.json)
- [Cachix](https://cachix.org) - Nix binary cache hosting: [several caches](nix/cachix.nix)
- [Niv updater GitHub action](https://github.com/knl/niv-updater-action) - creating meaningful pull requests with Niv updates: [corresponding configuration](.github/workflows/niv-updates.yaml)
- [Cachix Github Action](https://github.com/cachix/cachix-action) - checking builds on push and keeping cachix up-to-date: [corresponding configuration](.github/workflows/cachix.yaml)
- _TODO_: move onto [nix flakes](https://nixos.wiki/wiki/Flakes) 🤔

## Miscellaneous Package Confgurations

- <img src="https://simpleicons.org/icons/visualstudiocode.svg" height="12pt"> [VS Code](home/home/development/vscode/default.nix)
- <img src="https://simpleicons.org/icons/git.svg" height="12pt"> [git](home/common/git/default.nix)
- <img src="https://simpleicons.org/icons/starship.svg" height="12pt"> [zsh](home/common/zsh.nix)
  and [starship](home/common/starship.nix)
- <img src="https://simpleicons.org/icons/firefox.svg" height="12pt"> [Firefox](home/home/firefox/)
  using [Material Fox](https://github.com/muckSponge/MaterialFox/)
  and [User.js privacy configuration](https://github.com/pyllyukko/user.js)
- <img src="https://simpleicons.org/icons/docker.svg" height="12pt"> [Docker](host/services/docker/default.nix)

---

- [Little terminal package subset to use at work in Ubuntu WSL 🙈](home/work/default.nix)

## Usage

There is a [script file](make.sh) to escape boilerplate routine. There are following subcommands:

- `link` - add needed links
- `build` - just build configuration derivation
- `switch` - build & switch on it
- `clean` - clean up generations

## WSL Ubuntu installation guide

- `sudo mkdir -p /etc/nix`
- `/etc/nix/nix.conf` (requires `sudo`):
  ```
  sandbox = false
  use-sqlite-wal = false
  ```
- `sh <(curl -L https://nixos.org/nix/install) --no-daemon`
- `nix-channel --add http://github.com/nix-community/home-manager/archive/master.tar.gz home-manager`
- `nix-channel --update`
- `nix-shell '<home-manager>' -A install`
- clone this repo into `/home/{user}/.config/nixpkgs`
- `ln -fs nixconfigs/home/work/default.nix home.nix`
- `home-manager switch`
- `sudo chsh -s $(which zsh) {user}`

## Inspiration

- My bro's configuration [QuentinI/dotnix](https://github.com/QuentinI/dotnix/)
