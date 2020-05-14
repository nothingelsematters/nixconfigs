{ pkgs, ... }:

with pkgs;
config.lib.functions.getScript ./calendar-popup.sh [ yad xdotool ]
