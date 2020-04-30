{ config, pkgs, lib, ... }:

let theme = import ../theme { inherit pkgs lib; };
in {
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
  xresources.extraConfig = theme.xresources;
}
