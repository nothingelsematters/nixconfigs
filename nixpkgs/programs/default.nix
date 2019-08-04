{ config, pkgs, ... }:

{
  imports = [
    ./bat
    ./browserpass
    ./most
    ./fzf
    ./zsh
    ./firefox
  ];
}
