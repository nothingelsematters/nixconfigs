{ config, pkgs, ... }:

{
  imports = [
    ./background
    ./guake
    ./nm-applet
    ./udiskie
    ./unclutter
  ];
}
