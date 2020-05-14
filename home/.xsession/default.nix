{ config, pkgs, lib, ... }:

{
  imports = [
    ./background
    ./compton
    ./dunst
    ./i3
    ./libinput-gestures
    ./polybar
    ./screen-locker
    ./unclutter
    ./mime.nix
  ];
  xsession.enable = true;
  xresources.extraConfig = config.lib.theme.xresources;
}
