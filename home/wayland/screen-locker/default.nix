{ config, pkgs, lib, ... }:

let getScript = import ../../lib/getScript.nix { inherit pkgs; };
in {
  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = with pkgs; getScript ./lock.sh [ imagemagick swaylock grim ];
  };
}
