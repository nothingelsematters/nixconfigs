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
    ./check-battery
    ./i3lock-fancy
  ];
}
