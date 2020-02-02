{ config, pkgs, lib, ... }:

let
  theme = import ../../theme { inherit pkgs; };
  mkINI = import ../../theme/lib/mkINI.nix;
  cfg = builtins.readFile ./config.ini;
  height = "20";
  bin = x: builtins.concatStringsSep ":" (builtins.map (y: y + "/bin") x);

  calendarPopupName = "calendar-popup.sh";
  calendarPopup = pkgs.writeShellScriptBin calendarPopupName ''
    #!/bin/sh

    YAD=${pkgs.yad}/bin/yad
    XDOTOOL=${pkgs.xdotool}/bin/xdotool

    BAR_HEIGHT=$((${height} + 8))
    BORDER_SIZE=0
    YAD_WIDTH=222
    YAD_HEIGHT=150

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
    script = with pkgs; "PATH=$PATH:${bin [ i3 rofi alacritty htop networkmanager_dmenu bash ]} polybar top &";

    extraConfig = ''
      ${mkINI theme.colors}

      [tricks]
      font-notification = ${theme.fonts.notification}:pixelsize=9;1
      charging =  %{F${theme.colors.text.primary}}%percentage%%%{F-}
      muted =  %{F${theme.colors.text.primary}}mute%{F-}
      disconnected = %{A1:networkmanager_dmenu &:}  %{A}
      connected = %{A1:networkmanager_dmenu &:}%{F${theme.colors.text.secondary}} <ramp-signal> <label-connected>%{F-}%{A}
      time = %{A1:${calendarPopup}/bin/${calendarPopupName} &:}%a %H:%M%{A}
      height = ${height}

      ${cfg}
    '';
  };
}
