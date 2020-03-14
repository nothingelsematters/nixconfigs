swaymsg mark __moving

read -r X Y W H G ID < <(slurp -b '#ffffff33' -c '#717790ff' -f '%x %y %w %h %g %i')

if [ -z "$X" ]; then
swaymsg unmark __moving
exit;
fi;

swaymsg [con_mark="__moving"] floating enable
swaymsg [con_mark="__moving"] move position $X $Y

if [ "$W" -eq "0" ]; then
swaymsg unmark __moving
exit;
fi;

swaymsg [con_mark="__moving"] resize set $W $H
swaymsg unmark __moving
