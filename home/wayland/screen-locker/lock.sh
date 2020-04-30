grim /tmp/lock_screenshot.jpg

date=$(date '+%A %W %B %Y %R')

convert /tmp/lock_screenshot.jpg -filter point -blur 0x10 \
    -font Comfortaa-Regular -family Comfortaa-Regular  \
    -fill "#e2e2e4" -pointsize 25 -draw "text 500,490 '$date'" \
    -pointsize 15 -draw "text 600,525 '>> slide to unlock >>'" \
    /tmp/lock_screenshot.png

swaylock -i /tmp/lock_screenshot.png -e -f -k --font Comfortaa --font-size 12 \
    --indicator-thickness 5 \
    --indicator-idle-visible --indicator-radius 60 \
    --indicator-x-position 680 --indicator-y-position 340
