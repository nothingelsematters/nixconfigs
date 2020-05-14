{ config, pkgs, lib, ... }:

{
  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = with pkgs;
      config.lib.functions.toScript "lock.sh" [ swaylock-effects grim ] ''
        grim /tmp/lock_screenshot.jpg

        swaylock --clock --font Comfortaa --font-size 20 -e -f -K \
          --indicator-idle-visible --indicator-radius 100 \
          --indicator-thickness 5 -i /tmp/lock_screenshot.jpg --effect-blur 4x10
      '';
  };
}
