{ config, pkgs, lib, ... }:

let
  getScript = import ../../lib/getScript.nix { inherit pkgs; };
  lockCmd = with pkgs;
    getScript ./lock.sh [ imagemagick swaylock-effects grim ];
in {
  systemd.user.services.screen-locker = {
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "swayidle -w timeout 600 '${lockCmd}'";
      Restart = "on-abort";
    };
  };
}
