{ config, pkgs, ... }:

let
  getScript = import ../../lib/getScript.nix { inherit pkgs; };
  startScript = with pkgs;
    getScript ./check-battery.sh [ acpi ripgrep notify-desktop coreutils ];
in {
  systemd.user.services.check-battery = {
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = startScript;
      Restart = "on-abort";
    };
  };
}
