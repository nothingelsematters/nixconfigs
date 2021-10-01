{ config, pkgs, ... }:

{
  systemd.user.services.battery-notification = {
    Unit = {
      Description = "Sends a notification on low battery";
      PartOf = [ "graphical-session.target" ];
    };

    Install.WantedBy = [ "graphical-session.target" ];

    Service = {
      Restart = "on-abort";
      ExecStart = with pkgs;
        config.lib.functions.getScript ./battery-notification.sh [
          acpi
          coreutils
          jq
          notify-desktop
        ];
    };
  };
}
