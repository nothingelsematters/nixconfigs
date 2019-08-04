#!/bin/sh

USERNAME="simon"
HOME="/home/"$USERNAME
PROGRAMS="nixpkgs/programs"
SERVICES="nixpkgs/services"

declare -A symlinks
symlinks=(
    [$HOME/.config]=nixpkgs
    [/etc]=nixos
    [$HOME/.atom]=$PROGRAMS/atom/config.cson
    [$HOME/.config]=$PROGRAMS/libinput-gestures/libinput-gestures.conf
)

for i in "${!symlinks[@]}"
do
    sudo ln -srft $i ${symlinks[$i]}
done

guake --restore-preferences $SERVICES/guake/preferences.conf

# apm install --packages-file $PROGRAMS/atom/atom-packages.txt

### manually : import firefox bookmarks from nixpkgs/programs/firefox/bookmarks.json
