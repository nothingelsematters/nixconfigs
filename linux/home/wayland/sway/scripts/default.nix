{ config, pkgs, ... }:

with config.lib;
with functions;
let python = pkgs.python3.withPackages (ps: with ps; [ i3ipc ]) + /bin/python3;
in {
  inactive-transparency = "${python} ${./inactive-transparency.py} -o 0.86";

  resize = with pkgs;
    with builtins;
    with config.wayland.windowManager.sway.config;
    toScript "resize.sh" [ slurp sway ] ''
      read -r X Y W H < <(slurp -b '#ffffff33' -c '#717790ff' -f '%x %y %w %h')

      GAPS=${toString (gaps.inner + gaps.outer + 1)}
      X=$(($X - $GAPS))
      Y=$(($Y - $GAPS - ${toString constants.barHeight}))

      if (( $X >= 0 && $Y >= 0 )); then
          swaymsg mark __moving
          swaymsg [con_mark="__moving"] floating enable
          swaymsg [con_mark="__moving"] resize set $W $H
          swaymsg [con_mark="__moving"] move position $X $Y
      fi
    '';

  screen-lock = toScript "screen-lock.sh" [ pkgs.swaylock-effects ] ''
    swaylock --daemonize \
      --ignore-empty-password  --hide-keyboard-layout \
      --screenshots --effect-blur 4x10 --effect-vignette 0.3:0.6 \
      --clock --font Comfortaa --font-size 20 \
      --indicator-idle-visible --indicator-radius 90 \
      --indicator-thickness 2 --inside-color '#00000000' \
      --line-uses-ring
  '';
}
