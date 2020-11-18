{ config, pkgs, ... }:

with config.lib;
with functions;
with theme.colors; {
  max-length = 70;
  exec = with pkgs;
    toScript "waybar-spotify.sh" [ sway playerctl ] ''
      while true; do
          swaymsg -t subscribe '[ "window" ]' > /dev/null

          case "$( playerctl status -p spotify )" in
              "" )
                  echo ""
                  ;;

              "Paused" )
                  echo "<span foreground=\"${text.disabled}\"> " \
                      "$( playerctl metadata artist -p spotify ) — " \
                      "$( playerctl metadata title -p spotify )</span>"
                  ;;

              "Playing" )
                  echo "<span foreground=\"${text.secondary}\"> " \
                      "$( playerctl metadata artist -p spotify ) — " \
                      "$( playerctl metadata title -p spotify )</span>"
                  ;;
          esac
      done
    '';
  on-click = "${pkgs.playerctl}/bin/playerctl play-pause -p spotify";
  tooltip = false;
}
