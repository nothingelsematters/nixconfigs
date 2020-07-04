BFILE=/sys/class/backlight/intel_backlight/brightness

function get_brightness {
    cat $BFILE
}

function send_notification {
    icon="preferences-system-brightness-lock"
    brightness=$(get_brightness)
    bar=$(seq -s "─" 0 $((brightness / 180)) | sed 's/[0-9]//g')
    notify-desktop -t 1000 -i "$icon" -r 5555 -u normal "$((brightness / 60))%" "$bar"
}

case $1 in
    up)
        echo $(($(cat $BFILE) + 100)) > $BFILE
        send_notification
        ;;
    down)
        echo $(($(cat $BFILE) - 100)) > $BFILE
        send_notification
        ;;
esac
