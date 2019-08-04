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
    ./libinput-gestures
  ];
}
