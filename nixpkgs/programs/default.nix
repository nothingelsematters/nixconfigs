{ config, pkgs, ... }:

{
  imports = [
    ./browserpass
    ./most
    ./zsh
    ./firefox
  ];
}
