{ config, pkgs, ... }:

{
  imports = [
    ./guake
    ./nm-applet
    ./udiskie
    ./unclutter
    ./polybar
    ./compton
  ];
}
