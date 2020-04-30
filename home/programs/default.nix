{ config, pkgs, ... }:

{
  imports = [
    ./bat
    ./browserpass
    ./firefox
    ./fzf
    ./htop
    ./kitty
    ./most
    ./networkmanager-dmenu
    ./z-lua
    ./zsh
  ];
}
