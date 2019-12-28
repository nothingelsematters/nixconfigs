#!/bin/sh

PROGRAMS="nixpkgs/programs"

declare -A symlinks
symlinks=(
    [$HOME/.config]=nixpkgs
    [/etc]=nixos
    [$HOME/.atom]=$PROGRAMS/atom/config.cson
)

for i in "${!symlinks[@]}"
do
    sudo ln -srft $i ${symlinks[$i]}
done

apm install --packages-file $PROGRAMS/atom/atom-packages.txt

### manually : import firefox bookmarks from nixpkgs/programs/firefox/bookmarks.json
