BAR_HEIGHT=$(($1 + 8))
BORDER_SIZE=0
YAD_WIDTH=222
YAD_HEIGHT=150

if [ "$($XDOTOOL getwindowfocus getwindowname)" = "yad-calendar" ]; then
    exit 0
fi

eval "$($XDOTOOL getmouselocation --shell)"
eval "$($XDOTOOL getdisplaygeometry --shell)"

# X
if [ "$((X + YAD_WIDTH / 2 + BORDER_SIZE))" -gt "$WIDTH" ]; then #Right side
    : $((pos_x = WIDTH - YAD_WIDTH - BORDER_SIZE))
elif [ "$((X - YAD_WIDTH / 2 - BORDER_SIZE))" -lt 0 ]; then #Left side
    : $((pos_x = BORDER_SIZE))
else #Center
    : $((pos_x = X - YAD_WIDTH / 2))
fi

# Y
if [ "$Y" -gt "$((HEIGHT / 2))" ]; then #Bottom
    : $((pos_y = HEIGHT - YAD_HEIGHT - BAR_HEIGHT - BORDER_SIZE))
else #Top
    : $((pos_y = BAR_HEIGHT + BORDER_SIZE))
fi

$YAD --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
    --width=$YAD_WIDTH --height=$YAD_HEIGHT --posx=$pos_x --posy=$pos_y \
    --title="yad-calendar" --borders=0 >/dev/null &
