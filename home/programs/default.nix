{ config, pkgs, ... }:

{
  imports = [
    ./bat
    ./browserpass
    ./dircolors
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
