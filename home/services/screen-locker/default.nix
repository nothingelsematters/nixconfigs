{ config, pkgs, lib, ... }:

{
  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock blur";
  };

  home.activation.screen-locker = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    test ! -e $HOME/.cache/i3lock/current/blur.png && ${pkgs.betterlockscreen}/bin/betterlockscreen -u ${
      ../background/background.jpg
    } --blur
  '';
}
