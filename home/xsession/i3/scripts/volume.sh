function get_volume {
    amixer get Master | rg '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | rg '%' | rg -oe '[^ ]+$' | rg off > /dev/null
}

function send_notification {
    nl=$'\n'
    if is_mute ; then
        notify-desktop -t 1000 -i "audio-volume-muted" -r 2593 -u normal "$nl mute"
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

        notify-desktop -t 1000 -i $icon -r 2593 -u normal "$volume%" "$bar"
    fi
}

case $1 in
    up)
        amixer set Master on > /dev/null
        amixer sset Master 5%+ > /dev/null
        send_notification
        ;;
    down)
        amixer set Master on > /dev/null
        amixer sset Master 5%- > /dev/null
        send_notification
        ;;
    mute)
        amixer set Master 1+ toggle > /dev/null
        send_notification
        ;;
esac
