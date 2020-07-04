NOT_ALARMED=0

while :
do
    BATTERY=$(acpi -b | jq -R 'capture(".*: (?<status>.*), (?<percent>\\\\d+)%, (?<info>.*)")')
    STATUS=$(echo $BATTERY | jq -r '.status')
    PERCENT=$(echo $BATTERY | jq -r '.percent')
    INFO=$(echo $BATTERY | jq -r '.info')

    if [[ $NOT_ALARMED -lt 2 && $STATUS == "Discharging" && $PERCENT -lt 11 ]] ; then
        DISPLAY=:0 notify-desktop -u critical -i battery-caution "critically low battery" "$INFO"
        NOT_ALARMED=2
    fi

    if [[ $NOT_ALARMED -lt 1 && $STATUS == "Discharging" && $PERCENT -lt 21 ]] ; then
        DISPLAY=:0 notify-desktop -u normal -i battery-low "low battery" "$INFO"
        NOT_ALARMED=1
    fi

    if [[ ($STATUS == "Charging" || $STATUS == "Full") && $PERCENT -gt 94 ]] ; then
        DISPLAY=:0 notify-desktop -u normal -i battery-full "battery charged"
        sleep 1800
    fi

    if [[ $STATUS == "Charging" ]]; then
        NOT_ALARMED=0
    fi

    sleep 5
done
