{ config, pkgs, ... }:

let
  startScript = pkgs.writeShellScriptBin "check-battery.sh" ''
    ACPI=${pkgs.acpi}/bin/acpi
    GREP=${pkgs.ripgrep}/bin/rg
    NOTIFY=${pkgs.notify-desktop}/bin/notify-desktop;
    SLEEP=${pkgs.coreutils}/bin/sleep
    CUT=${pkgs.coreutils}/bin/cut
    NOT_ALARMED=0

    while :
    do
        DISCHARGING=`$ACPI -b | $GREP Discharging`
        CHARGING=`$ACPI -b | $GREP Charging`
        FULL=`$ACPI -b | $GREP Full`
        PROCENT=`$ACPI -b | $CUT -f 4 -d " " | $CUT -f 1 -d "%"`
        INFO=`$ACPI -b | $CUT -f 3- -d " "`

        if [[ $NOT_ALARMED -lt 2 && $DISCHARGING && $PROCENT -lt 10 ]] ; then
            DISPLAY=:0 $NOTIFY -u critical -i battery-caution "critically low battery" "$INFO"
            NOT_ALARMED=2
        fi

        if [[ $NOT_ALARMED -lt 1 && $DISCHARGING && $PROCENT -lt 20 ]] ; then
            DISPLAY=:0 $NOTIFY -u normal -i battery-low "low battery" "$INFO"
            NOT_ALARMED=1
        fi

        if [[ ($CHARGING || $FULL) && $PROCENT -gt 94 ]] ; then
            DISPLAY=:0 $NOTIFY -u normal -i battery-full "battery charged"
            $SLEEP 1800
        fi

        if [[ $CHARGING ]]; then
            NOT_ALARMED=0
        fi

        $SLEEP 5
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
