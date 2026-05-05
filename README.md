<p align="center"><img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo.svg" width=384></p>

<p align="center">
    <a href="https://builtwithnix.org/">
        <img src="https://img.shields.io/badge/built with-nix-blue?style=flat-square&logo=nixos">
    </a>
    <a href="https://github.com/nothingelsematters">
        <img src="https://img.shields.io/github/commit-activity/y/nothingelsematters/nixconfigs?style=flat-square&logo=github">
    </a>
</p>

<h1 align="center"> custom <a href="https://nixos.org">nix</a> configuration </h1>

## Configuration

- <img src="https://simpleicons.org/icons/ghostty.svg" height="12pt"> [ghostty](home/terminal/ghostty)
- <img src="https://simpleicons.org/icons/starship.svg" height="12pt"> [zsh](home/terminal/zsh)
  with [starship](home/terminal/starship.nix)
- <img src="https://simpleicons.org/icons/rust.svg" height="12pt"> [rust](home/development/rust.nix)
- <img src="https://simpleicons.org/icons/git.svg" height="12pt"> [git](home/development/git.nix)
- <img src="https://simpleicons.org/icons/docker.svg" height="12pt"> [docker](home/development/docker.nix)

> A historic configuration with **NixOS linux** and **WSL linux**: [4cb13be](https://github.com/nothingelsematters/nixconfigs/tree/4cb13be652046935c9aee971b6a49d141f633993)

## Usage

[[Application usage guides]](home/)

### Installation

```sh
# Install Nix with Flakes
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Clone the repository
git clone git@github.com:nothingelsematters/nixconfigs.git

# Activate packages
nix build ".#home.activationPackage" && ./result/activate
```

### Update

`nix flake update .`

### Clean up

`nix-collect-garbage -d`
