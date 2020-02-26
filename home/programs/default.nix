{ config, pkgs, ... }:

{
  imports = [
    ./alacritty
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
    ./rofi
    ./zsh
  ];
}
