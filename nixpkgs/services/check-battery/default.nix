{ config, pkgs, ... }:

let
  startScript = pkgs.writeShellScriptBin "check-battery.sh" ''
    ACPI=${pkgs.acpi}/bin/acpi
    GREP=${pkgs.ripgrep}/bin/rg
    BATTINFO=`$ACPI -b`
    NOTIFY=${pkgs.notify-desktop}/bin/notify-desktop;
    SLEEP=${pkgs.coreutils}/bin/sleep

    while :
    do
      if [[ `echo $BATTINFO | $GREP Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:30:00 ]] ; then
          DISPLAY=:0 $NOTIFY -u critical "low battery" "$BATTINFO"
      fi

      if [[ `echo $BATTINFO | $GREP Charging` && `echo $BATTINFO | cut -f 4 -d " "` == 100%, ]] ; then
          DISPLAY=:0 $NOTIFY -u normal "battery fully charged"
      fi

      $SLEEP 30
    done
  '';
in

{
  home.packages = with pkgs; [ coreutils acpi ripgrep notify-desktop ];
  systemd.user.services.check-battery = {
      Install = {
          WantedBy = [ "graphical-session.target" ];
      };
      Service = {
          ExecStart = "${startScript}/bin/check-battery.sh";
          Restart = "on-abort";
      };
  };
}
