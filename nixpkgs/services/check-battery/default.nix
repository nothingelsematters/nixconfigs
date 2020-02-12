{ config, pkgs, lib, ... }:

let
  getScript = import ../../lib/getScript.nix { inherit pkgs lib; };
  startScript = with pkgs; getScript ./. "check-battery.sh" [
    [ acpi "acpi" ]
    [ ripgrep "rg" ]
    [ notify-desktop "notify-desktop" ]
    [ coreutils "sleep" ]
    [ coreutils "cut" ]
  ];
in
{
  home.packages = with pkgs; [ coreutils acpi ripgrep notify-desktop ];
  systemd.user.services.check-battery = {
      Install = {
          WantedBy = [ "graphical-session.target" ];
      };
      Service = {
          ExecStart = startScript;
          Restart = "on-abort";
      };
  };
}
