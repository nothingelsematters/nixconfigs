#!/bin/sh

USERNAME="simon"
HOME="/home/"$USERNAME

declare -A symlinks
symlinks=(
    [$HOME/.config]=nixpkgs
    [/etc]=nixos
    [$HOME/.atom]=nixpkgs/programs/atom/config.cson
    [$HOME/.atom]=nixpkgs/programs/atom/snippets.cson
    [$HOME/.config]=nixpkgs/programs/libinput-gestures/libinput-gestures.conf
)

for i in "${!symlinks[@]}"
do
    sudo ln -srft $i ${symlinks[$i]}
done

# apm install --packages-file nixpkgs/programs/atom/atom-packages.txt

### manually : import firefox bookmarks from nixpkgs/programs/firefox/bookmarks.json
