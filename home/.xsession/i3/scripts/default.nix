{ pkgs, ... }:

let getScript' = x: y: "exec " + config.lib.functions.getScript x y;
in {
  resize = with pkgs; getScript' ./resize.sh [ slop i3-gaps ];

  brightness = with pkgs;
    getScript' ./brightness.sh [ coreutils gnused notify-desktop ];

  volume = with pkgs;
    getScript' ./volume.sh [ alsaUtils notify-desktop ripgrep coreutils ];
}
