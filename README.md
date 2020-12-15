<p align="center"><img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo.svg" width=512></p>

<p align="center">
    <a href="https://github.com/nothingelsematters">
        <img src="https://img.shields.io/github/commit-activity/y/nothingelsematters/nixconfigs?style=flat-square&logo=github">
    </a>
    <a href="https://nixos.org">
        <img src="https://img.shields.io/badge/generations-320-green?style=flat-square&logo=nixos">
    </a>
    <a href="https://travis-ci.com/github/nothingelsematters/nixconfigs/builds">
        <img alt="Travis (.com)" src="https://img.shields.io/travis/com/nothingelsematters/nixconfigs?style=flat-square&logo=travis">
    </a>
    <a href="https://www.codefactor.io/repository/github/nothingelsematters/nixconfigs">
        <img src="https://img.shields.io/codefactor/grade/github/nothingelsematters/nixconfigs?style=flat-square&logo=codefactor">
    </a>
</p>

<h1 align="center"> custom <a href="https://nixos.org">NixOS</a> configuration </h1>

## Nix tools being used

+ [Cachix](https://cachix.org) - Nix binary cache hosting: [several caches](nix/cachix.nix)
+ [Niv](https://github.com/nmattia/niv) - Easy dependency management for Nix project: [generated `source.json` file](nix/sources.json)
+ [Niv updater GitHub action](https://github.com/knl/niv-updater-action) - GitHub Action creating meaningful pull requests with Niv updates: [corresponding configuration](.github/workflows/niv-updates.yaml)
+ [Travis CI](https://travis-ci.org) checking building: [travis configuration](.travis.yml)

## Usage

There is a [script file](make.sh) to escape boilerplate routine. There are following subcommands:

+ `link` - add needed links
+ `build` - just build configuration derivation
+ `switch` - build & switch on it
+ `clean` - clean up generations
