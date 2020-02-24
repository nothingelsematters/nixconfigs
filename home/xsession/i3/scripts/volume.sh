function get_volume {
    $AMIXER get Master | $RG '%' | head -n 1 | $CUT -d '[' -f 2 | $CUT -d '%' -f 1
}

function is_mute {
    $AMIXER get Master | $RG '%' | $RG -oe '[^ ]+$' | $RG off > /dev/null
}

function send_notification {
    nl=$'\n'
    if is_mute ; then
        $NOTIFYDESKTOP -t 1000 -i "audio-volume-muted" -r 2593 -u normal "$nl mute"
    else
        volume=$(get_volume)
        bar=$(seq --separator="─" 0 "$((volume / 3))" | sed 's/[0-9]//g')

        if [[ $volume -lt 20 ]] ; then
            icon="audio-volume-low"
        fi

        if [[ $volume -ge 20 && $volume -lt 60 ]] ; then
            icon="audio-volume-medium"
        fi

        if [[ $volume -ge 60 ]] ; then
            icon="audio-volume-high"
        fi

        $NOTIFYDESKTOP -t 1000 -i $icon -r 2593 -u normal "$volume%" "$bar"
    fi
}

case $1 in
    up)
        $AMIXER set Master on > /dev/null
        $AMIXER sset Master 5%+ > /dev/null
        send_notification
        ;;
    down)
        $AMIXER set Master on > /dev/null
        $AMIXER sset Master 5%- > /dev/null
        send_notification
        ;;
    mute)
        $AMIXER set Master 1+ toggle > /dev/null
        send_notification
        ;;
esac
