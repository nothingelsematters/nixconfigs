{ config, pkgs, ... }:

let
  startScript = pkgs.writeShellScriptBin "check-battery.sh" ''
    ACPI=${pkgs.acpi}/bin/acpi
    GREP=${pkgs.ripgrep}/bin/rg
    BATTINFO=`$ACPI -b`
    NOTIFY=${pkgs.notify-desktop}/bin/notify-desktop;
    SLEEP=${pkgs.coreutils}/bin/sleep

    DISCHARGING=`echo $BATTINFO | $GREP Discharging`
    CHARGING=`echo $BATTINFO | $GREP Charging`
    PROCENT=`echo $BATTINFO | cut -f 4 -d " " | cut -f 1 -d "%"`
    INFO=`echo $BATTINFO | cut -f 3- -d " "`


    while :
    do
        proc=$PROCENT

        if [[ $DISCHARGING && $proc -lt 10 ]] ; then
          DISPLAY=:0 $NOTIFY -u critical "critically low battery" "$INFO"
          $SLEEP 300
          continue
        fi

        if [[ $DISCHARGING && $proc -lt 20 ]] ; then
          DISPLAY=:0 $NOTIFY -u normal "low battery" "$INFO"
          $SLEEP 300
          continue
        fi

        if [[ $CHARGING && $proc -gt 94 ]] ; then
          DISPLAY=:0 $NOTIFY -u normal "battery charged"
          $SLEEP 1800
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
