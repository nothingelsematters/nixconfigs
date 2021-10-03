<p align="center"><img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo.svg" width=512></p>

<p align="center">
    <a href="https://builtwithnix.org/">
        <img src="https://img.shields.io/badge/built with-nix-blue?style=flat-square&logo=nixos">
    </a>
    <a href="https://github.com/nothingelsematters">
        <img src="https://img.shields.io/github/commit-activity/y/nothingelsematters/nixconfigs?style=flat-square&logo=github">
    </a>
    <a href="https://www.codefactor.io/repository/github/nothingelsematters/nixconfigs">
        <img src="https://img.shields.io/codefactor/grade/github/nothingelsematters/nixconfigs?style=flat-square&logo=codefactor">
    </a>
</p>

<h1 align="center"> custom <a href="https://nixos.org">nix</a> configuration </h1>

## Nix tools being used

- [Nix Flakes](https://nixos.wiki/wiki/Flakes) - dependency specification feature
- [Cachix](https://cachix.org) - Nix binary cache hosting

## Configurations

### NixOS

[Home manager](home/home/) and [host](host/) configurations.

- <img src="https://simpleicons.org/icons/visualstudiocode.svg" height="12pt"> [VS Code](home/home/development/vscode/default.nix)
- <img src="https://simpleicons.org/icons/git.svg" height="12pt"> [git](home/common/development/git.nix)
- <img src="https://simpleicons.org/icons/starship.svg" height="12pt"> [zsh](home/common/terminal/zsh.nix)
  and [starship](home/home/terminal/starship.nix)
- <img src="https://simpleicons.org/icons/firefox.svg" height="12pt"> [Firefox](home/home/firefox/)
  using [Material Fox](https://github.com/muckSponge/MaterialFox/)
  and [User.js privacy configuration](https://github.com/pyllyukko/user.js)
- <img src="https://simpleicons.org/icons/docker.svg" height="12pt"> [Docker](host/services/docker.nix)

### Windows Subsystem Linux (Ubuntu)

- [WSL 1](home/wsl/wsl-1.nix).
  In the first WSL version [z-lua](https://github.com/skywind3000/z.lua) package doesn't work,
  it just kills the CPU somehow.
  However, in this version every CPU bound task performs better than on the second version due to virtualization method.

- [WSL 2](home/wsl/wsl-2.nix).
  In the second WSL version [docker compose](https://docs.docker.com/compose/) works properly
  because of the virtualization method.

### MacOS

[Configuration](home/mac/default.nix)

## Usage

### NixOS

- Build: `sudo nixos-rebuild switch --flake . --keep-going`
- Update: `nix flake update .`
- Clean up generations: `sudo nix-collect-garbage -d`

### WSL and MacOS

#### Install nix

- WSL
  - `sudo mkdir -p /etc/nix`
  - `/etc/nix/nix.conf` (requires `sudo`):
    ```
    sandbox = false
    use-sqlite-wal = false
    ```
  - `sh <(curl -L https://nixos.org/nix/install) --no-daemon`
- MacOS
  - `sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume`

#### Install nix flakes

- `nix-env -iA nixpkgs.nixFlakes`
- `~/.config/nix/nix.conf`:
  ```
  experimental-features = nix-command flakes
  ```

#### Use configuration

- clone this repo
- activate packages
  - WSL: `nix build .#homeManagerConfigurations.wsl<number>.activatePackage`
  - MacOS: `nix build .#homeManagerConfigurations.mac.activatePackage`
- `./result/activate`

There is an alias for the last two commands after you do this for the first time: `hms`.

## Inspiration

- My bro's configuration [QuentinI/dotnix](https://github.com/QuentinI/dotnix/)
