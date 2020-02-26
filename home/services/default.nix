{ config, pkgs, ... }:

{
  imports = [
    ./background
    ./check-battery
    ./compton
    ./dunst
    ./i3lock-fancy
    ./libinput-gestures
    ./polybar
    ./udiskie
    ./unclutter
  ];
}
