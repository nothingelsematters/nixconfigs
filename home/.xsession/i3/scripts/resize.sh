i3-msg mark __moving

read -r X Y W H G ID < <(slop -f '%x %y %w %h %g %i')

if [ -z "$X" ]; then
  i3-msg unmark __moving
  exit;
fi;

i3-msg [con_mark="__moving"] floating enable
i3-msg [con_mark="__moving"] move position $X $Y

if [ "$W" -eq "0" ]; then
  i3-msg unmark __moving
  exit;
fi;

i3-msg [con_mark="__moving"] resize set $W $H
i3-msg unmark __moving
