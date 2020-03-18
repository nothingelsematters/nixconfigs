grim /tmp/lock_screenshot.jpg

date=$(date '+%A %W %B %Y %R')

convert /tmp/lock_screenshot.jpg -filter point -blur 0x3 \
    -fill "#333333" -draw "rectangle 50,600,420,700" \
    -font Comfortaa-Regular -family Comfortaa-Regular  \
    -fill "#e2e2e4" -pointsize 15 -draw "text 150,630 '$date'" \
    -pointsize 12 -draw "text 150,650 '>> slide to unlock >>'" \
    /tmp/lock_screenshot.png

swaylock -i /tmp/lock_screenshot.png -e -f -k --font Comfortaa --indicator-thickness 5 \
    --indicator-idle-visible --indicator-radius 30 \
    --indicator-x-position 100 --indicator-y-position 640
