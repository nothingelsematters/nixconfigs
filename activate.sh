#!/bin/sh

USERNAME="simon"

declare -A symlinks
symlinks=([/home/$USERNAME/.config]=nixpkgs
          [/etc]=nixos
          [/home/$USERNAME/.atom]=nixpkgs/programs/atom/config.cson
          [/home/$USERNAME/.atom]=nixpkgs/programs/atom/snippets.cson)

for i in "${!symlinks[@]}"
do
    sudo ln -srft $i ${symlinks[$i]}
done

# apm install --packages-file nixpkgs/programs/atom/atom-packages.txt

### manually : import firefox bookmarks from nixpkgs/programs/firefox/bookmarks.json
