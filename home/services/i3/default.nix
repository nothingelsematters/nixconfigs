{ config, ... }:

{
  imports = [
    ./background
    ./compton
    ./dunst
    ./libinput-gestures
    ./polybar
    ./screen-locker
  ];
}
