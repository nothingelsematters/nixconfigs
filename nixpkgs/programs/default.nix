{ config, pkgs, ... }:

{
  imports = [
    ./atom
    ./bat
    ./browserpass
    ./most
    ./fzf
    ./zsh
    ./firefox
    ./rofi
    ./alacritty
    ./networkmanager-dmenu
  ];
}
