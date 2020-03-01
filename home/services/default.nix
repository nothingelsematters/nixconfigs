{ config, pkgs, ... }:

{
  imports = [ ./check-battery ./libinput-gestures ./udiskie ./unclutter ];
}
