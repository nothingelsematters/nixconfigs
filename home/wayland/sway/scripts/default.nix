{ config, pkgs, ... }:

with config.lib.functions;
let python = pkgs.python3.withPackages (ps: with ps; [ i3ipc ]) + /bin/python3;
in {
  inactive-transparency = "${python} ${./inactive-transparency.py} -o 0.86";

  resize = with pkgs; "exec " + getScript ./resize.sh [ slurp sway ];

  screen-lock = with pkgs;
    toScript "screen-lock.sh" [ swaylock-effects grim ] ''
      swaylock --daemonize \
        --ignore-empty-password  --hide-keyboard-layout \
        --screenshots --effect-blur 4x10 --effect-vignette 0.3:0.6 \
        --clock --font Comfortaa --font-size 20 \
        --indicator-idle-visible --indicator-radius 90 \
        --indicator-thickness 2 --inside-color '#00000000' \
        --line-uses-ring
    '';
}
