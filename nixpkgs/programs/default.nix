{ config, pkgs, ... }:

{
  imports = [
    ./bat
    ./browserpass
    ./most
    ./zsh
    ./firefox
  ];
}
