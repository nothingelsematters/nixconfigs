<p align="center"><img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo.svg" width=512></p>

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

- <img src="https://simpleicons.org/icons/visualstudiocode.svg" height="12pt"> [vs code](home/development/vscode/)
- <img src="https://simpleicons.org/icons/starship.svg" height="12pt"> [zsh](home/terminal/zsh.nix)
  with [starship](home/terminal/starship.nix)
- <img src="https://simpleicons.org/icons/gnometerminal.svg" height="12pt"> [kitty](home/terminal/kitty)
- <img src="https://simpleicons.org/icons/git.svg" height="12pt"> [git](home/development/git.nix)
- <img src="https://simpleicons.org/icons/docker.svg" height="12pt"> [docker](home/development/docker.nix)

A historic configuration with **NixOS linux** and **WSL linux**: [4cb13be](https://github.com/nothingelsematters/nixconfigs/tree/4cb13be652046935c9aee971b6a49d141f633993)

## Usage

### Installation

- Install [nix](https://nixos.wiki/wiki/Nix_Expression_Language) \
  `sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume`

- Install nix [flakes](https://nixos.wiki/wiki/Flakes)

  ```shell
  nix-env -iA nixpkgs.nixFlakes
  mkdir -p ~/.config/nix/
  echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
  ```

- Clone the repository \
  `git clone git@github.com:nothingelsematters/nixconfigs.git`

- Activate packages

  - for the first time \
    `nix build .#mac.activationPackage && ./result/activate`

  - after the first time \
    `hms`

### Update

`nix flake update .`

### Clean up

`nix-collect-garbage -d`

## Inspiration

My bro's configuration [QuentinI/dotnix](https://github.com/QuentinI/dotnix/)
