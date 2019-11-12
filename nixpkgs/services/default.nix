{ config, pkgs, ... }:

{
  imports = [
    ./nm-applet
    ./udiskie
    ./unclutter
    ./polybar
    ./compton
    ./libinput-gestures
    ./dunst
    ./background
  ];
}
