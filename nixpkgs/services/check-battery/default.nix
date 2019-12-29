{ config, pkgs, ... }:

let
  startScript = pkgs.writeShellScriptBin "check-battery.sh" ''
    ACPI=${pkgs.acpi}/bin/acpi
    GREP=${pkgs.ripgrep}/bin/rg
    NOTIFY=${pkgs.notify-desktop}/bin/notify-desktop;
    SLEEP=${pkgs.coreutils}/bin/sleep
    CUT=${pkgs.coreutils}/bin/cut

    while :
    do
        DISCHARGING=`$ACPI -b | $GREP Discharging`
        CHARGING=`$ACPI -b | $GREP Charging`
        PROCENT=`$ACPI -b | $CUT -f 4 -d " " | $CUT -f 1 -d "%"`
        INFO=`$ACPI -b | $CUT -f 3- -d " "`

        if [[ $DISCHARGING && $PROCENT -lt 10 ]] ; then
            DISPLAY=:0 $NOTIFY -u critical "critically low battery" "$INFO"
            $SLEEP 300
            continue
        fi

        if [[ $DISCHARGING && $PROCENT -lt 20 ]] ; then
            DISPLAY=:0 $NOTIFY -u normal "low battery" "$INFO"
            $SLEEP 300
            continue
        fi

        if [[ $CHARGING && $PROCENT -gt 94 ]] ; then
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
