{ config, pkgs, lib, ... }:

let
  theme = import ../../themes { inherit pkgs; };
  mkINI = import ../../themes/lib/mkINI.nix;
  cfg = builtins.readFile ./config.ini;
  height = "24";

  calendarPopupName = "calendar-popup.sh";
  calendarPopup = pkgs.writeShellScriptBin calendarPopupName ''
    #!/bin/sh

    YAD=${pkgs.yad}/bin/yad
    XDOTOOL=${pkgs.xdotool}/bin/xdotool

    BAR_HEIGHT=$((${height} + 8))
    BORDER_SIZE=0
    YAD_WIDTH=222
    YAD_HEIGHT=193

    if [ "$($XDOTOOL getwindowfocus getwindowname)" = "yad-calendar" ]; then
        exit 0
    fi

    eval "$($XDOTOOL getmouselocation --shell)"
    eval "$($XDOTOOL getdisplaygeometry --shell)"

    # X
    if [ "$((X + YAD_WIDTH / 2 + BORDER_SIZE))" -gt "$WIDTH" ]; then #Right side
        : $((pos_x = WIDTH - YAD_WIDTH - BORDER_SIZE))
    elif [ "$((X - YAD_WIDTH / 2 - BORDER_SIZE))" -lt 0 ]; then #Left side
        : $((pos_x = BORDER_SIZE))
    else #Center
        : $((pos_x = X - YAD_WIDTH / 2))
    fi

    # Y
    if [ "$Y" -gt "$((HEIGHT / 2))" ]; then #Bottom
        : $((pos_y = HEIGHT - YAD_HEIGHT - BAR_HEIGHT - BORDER_SIZE))
    else #Top
        : $((pos_y = BAR_HEIGHT + BORDER_SIZE))
    fi

    $YAD --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --width=$YAD_WIDTH --height=$YAD_HEIGHT --posx=$pos_x --posy=$pos_y \
        --title="yad-calendar" --borders=0 >/dev/null &
    '';
in
{
  home.packages = [ pkgs.yad ];

  services.polybar = {
    enable  = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };

    extraConfig = ''
      ${mkINI theme.colors}
      [fonts]
      notification = ${theme.fonts.notification}:pixelsize=9;3
      ${cfg}
    '';

    script = "PATH=$PATH:${pkgs.i3}/bin:${pkgs.rofi}/bin:${pkgs.alacritty}/bin:${pkgs.htop}/bin:${pkgs.networkmanager_dmenu}/bin:${pkgs.bash}/bin"
      + " LABEL_CHARGING=\" %{F${theme.colors.text.primary}}%percentage%%%{F-}\""
      + " LABEL_MUTED=\" %{F${theme.colors.text.primary}}mute%{F-}\""
      + " LABEL_DISCONNECTED=\"%{A1:networkmanager_dmenu &:} %{F${theme.colors.text.primary}}[not connected]%{F-}%{A}\""
      + " FORMAT_CONNECTED=\"%{A1:networkmanager_dmenu &:}%{F${theme.colors.text.secondary}}  <ramp-signal> <label-connected>%{F-}%{A}\""
      + " TIME=\"%{A1:${calendarPopup}/bin/${calendarPopupName} &:}%H:%M%{A}\""
      + " HEIGHT=\"${height}\""
      + " polybar top &";
  };
}
