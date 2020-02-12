$I3MSG mark __moving

read -r X Y W H G ID < <($SLOP -f '%x %y %w %h %g %i')

if [ -z "$X" ]; then
  $I3MSG unmark __moving
  exit;
fi;

$I3MSG [con_mark="__moving"] floating enable
$I3MSG [con_mark="__moving"] move position $X $Y

if [ "$W" -eq "0" ]; then
  $I3MSG unmark __moving
  exit;
fi;

$I3MSG [con_mark="__moving"] resize set $W $H
$I3MSG unmark __moving
