grim /tmp/lock_screenshot.jpg
convert /tmp/lock_screenshot.jpg -filter point -resize 10% -resize 1000% /tmp/lock_screenshot.png
swaylock -i /tmp/lock_screenshot.png -e -f
