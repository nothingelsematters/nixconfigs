NOT_ALARMED=0

while :
do
    DISCHARGING=`acpi -b | rg Discharging`
    CHARGING=`acpi -b | rg Charging`
    FULL=`acpi -b | rg Full`
    PROCENT=`acpi -b | cut -f 4 -d " " | cut -f 1 -d "%"`
    INFO=`acpi -b | cut -f 3- -d " "`

    if [[ $NOT_ALARMED -lt 2 && $DISCHARGING && $PROCENT -lt 10 ]] ; then
        DISPLAY=:0 notify-desktop -u critical -i battery-caution "critically low battery" "$INFO"
        NOT_ALARMED=2
    fi

    if [[ $NOT_ALARMED -lt 1 && $DISCHARGING && $PROCENT -lt 20 ]] ; then
        DISPLAY=:0 notify-desktop -u normal -i battery-low "low battery" "$INFO"
        NOT_ALARMED=1
    fi

    if [[ ($CHARGING || $FULL) && $PROCENT -gt 94 ]] ; then
        DISPLAY=:0 notify-desktop -u normal -i battery-full "battery charged"
        sleep 1800
    fi

    if [[ $CHARGING ]]; then
        NOT_ALARMED=0
    fi

    sleep 5
done
