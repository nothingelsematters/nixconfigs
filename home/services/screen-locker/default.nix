{ config, pkgs, lib, ... }:

{
  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock blur";
  };

  home.activation.screen-locker = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.betterlockscreen}/bin/betterlockscreen -u ${../background/background.jpg} --blur
  '';
}
