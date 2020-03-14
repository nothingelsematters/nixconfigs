ws="$(swaymsg -p -t get_workspaces | rg Workspace | awk -F'[ ()]' '{ print $2 " " $4 }')"

case $1 in
    "next")
        rgflag="-A"
        cutcmd="tail"
        ;;
    "prev")
        rgflag="-B"
        cutcmd="head"
        ;;
    *)
        echo only "'prev'" and "'next'" are supported
        exit
        ;;
esac

needed="$(echo "$ws" | rg $rgflag 1 focused)"
if [[ `echo "$needed" | wc -l` != "1" ]]; then
    n="$(echo "$needed" | $cutcmd -n 1 | awk '{ print $1 }')"
    swaymsg workspace $n
fi
