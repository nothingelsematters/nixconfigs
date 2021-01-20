<p align="center"><img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo.svg" width=512></p>

<p align="center">
    <a href="https://github.com/nothingelsematters">
        <img src="https://img.shields.io/github/commit-activity/y/nothingelsematters/nixconfigs?style=flat-square&logo=github">
    </a>
    <a href="https://nixos.org">
        <img src="https://img.shields.io/badge/generations-330-green?style=flat-square&logo=nixos">
    </a>
    <a href="https://www.codefactor.io/repository/github/nothingelsematters/nixconfigs">
        <img src="https://img.shields.io/codefactor/grade/github/nothingelsematters/nixconfigs?style=flat-square&logo=codefactor">
    </a>
</p>

<h1 align="center"> custom <a href="https://nixos.org">NixOS</a> configuration </h1>

## Nix tools being used

+ [Niv](https://github.com/nmattia/niv) - Easy dependency management for Nix project: [generated `source.json` file](nix/sources.json)
+ [Cachix](https://cachix.org) - Nix binary cache hosting: [several caches](nix/cachix.nix)
+ [Niv updater GitHub action](https://github.com/knl/niv-updater-action) - creating meaningful pull requests with Niv updates: [corresponding configuration](.github/workflows/niv-updates.yaml)
+ [Cachix Github Action](https://github.com/cachix/cachix-action) - checking builds on push and keeping cachix up-to-date: [corresponding configuration](.github/workflows/cachix.yaml)

## Miscellaneous Package Confgurations

+ [VS Code](home/development/vscode/default.nix)
+ [git](home/development/git/default.nix)
+ [zsh](home/terminal/zsh/default.nix) and [starship](home/terminal/starship/default.nix)
+ [Firefox](home/firefox/)
  using [Material Fox](https://github.com/muckSponge/MaterialFox/)
  and [User.js privacy configuration](https://github.com/pyllyukko/user.js)
+ [Docker](services/docker/default.nix)

## Usage

There is a [script file](make.sh) to escape boilerplate routine. There are following subcommands:

+ `link` - add needed links
+ `build` - just build configuration derivation
+ `switch` - build & switch on it
+ `clean` - clean up generations
