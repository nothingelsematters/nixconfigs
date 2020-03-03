{ config, ... }:

{
  imports = [ ./check-battery ./libinput-gestures ./udiskie ./unclutter ];
}
