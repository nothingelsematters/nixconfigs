{ pkgs, ... }:

let getScript = import ../../../lib/getScript.nix { inherit pkgs; };
in with pkgs; getScript ./calendar-popup.sh [ yad xdotool ]
