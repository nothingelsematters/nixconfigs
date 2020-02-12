BFILE=/sys/class/backlight/intel_backlight/brightness

function get_brightness {
    $CAT $BFILE
}

function send_notification {
    icon="preferences-system-brightness-lock"
    brightness=$(get_brightness)
    bar=$($SEQ -s "─" 0 $((brightness / 180)) | $SED 's/[0-9]//g')
    $NOTIFYDESKTOP -t 1000 -i "$icon" -r 5555 -u normal "$((brightness / 60))%" "$bar"
}

case $1 in
    up)
        echo $(expr $($CAT $BFILE) + 100) > $BFILE
        send_notification
        ;;
    down)
        echo $(expr $($CAT $BFILE) - 100) > $BFILE
        send_notification
        ;;
esac
