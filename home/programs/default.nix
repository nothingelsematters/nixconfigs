{ config, pkgs, ... }:

{
  imports = [
    ./atom
    ./bat
    ./browserpass
    ./firefox
    ./fzf
    ./git
    ./htop
    ./kitty
    ./most
    ./networkmanager-dmenu
    ./z-lua
    ./zsh
  ];
}
