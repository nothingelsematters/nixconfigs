{ config, pkgs, lib, ... }:

let
  theme = import ../../theme { inherit pkgs; };
  mkINI = import ../../theme/lib/mkINI.nix;
  cfg = builtins.readFile ./config.ini;
  height = "22";

  bin = x: builtins.concatStringsSep ":" (builtins.map (y: y + "/bin") x);
  i3w-folder = ".config/polybar/i3-windows";
  modulePath = i3w-folder + "/module.py";
  commandPath = i3w-folder + "/command.py";
  python = pkgs.python3.withPackages (ps: with ps; [ i3ipc ]);

  addVars = with builtins; file: vars:
    let
      lines = filter isString (split "\n" (readFile file));
      isPrefix = prefix: str: stringLength prefix <= stringLength str && substring 0 (stringLength prefix) str == prefix;
      snd = x: elemAt x 1;
      folder = x: y:
        if head x
          then [ true (snd x ++ [ y ]) ]
          else (
            if (y == "" || isPrefix "import " y || isPrefix "from " y)
              then [ false (snd x ++ [ y ])]
              else [ true  (snd x ++ [ vars y ])]);
      patched = foldl' folder [ false [] ] lines;
    in concatStringsSep "\n" (snd patched);

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

  home.file = {
    "${commandPath}".source = ./i3-windows/command.py;
    "${modulePath}".text = addVars ./i3-windows/module.py ''
      focused = '${theme.colors.text.secondary}'
      wfocused = '${theme.colors.text.primary}'
      unfocused = '${theme.colors.text.disabled}'
      urgent = '${theme.colors.text.urgent}'

      empty = ''
      ICON_FONT = 3
      COMMAND = 'python3 ${commandPath}'
      ICONS = [
          ('class=Firefox', ''),
          ('class=Telegram', ''),
          ('class=Atom', ''),
          ('class=Alacritty', ''),
          ('class=libreoffice*', ''),
          ('*', ''),
      ]
      '';
  };

  services.polybar = {
    enable  = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };
    script = with pkgs; "PATH=$PATH:${bin [ i3 rofi alacritty htop networkmanager_dmenu bash python ]} polybar top &";

    extraConfig = ''
      ${mkINI theme.colors}

      [tricks]
      font-notification = ${theme.fonts.notification}:pixelsize=9;1
      charging =  %{F${theme.colors.text.primary}}%percentage%%%{F-}
      muted =  %{F${theme.colors.text.primary}}mute%{F-}
      connected = %{A1:networkmanager_dmenu &:}%{F${theme.colors.text.secondary}} <ramp-signal> <label-connected>%{F-}%{A}
      time = %{A1:${calendarPopup}/bin/${calendarPopupName} &:}%a %H:%M%{A}
      height = ${height}

      ${cfg}

      [module/i3-windows]
      type = custom/script
      exec = ${python}/bin/python3 ${modulePath}
      tail = true
    '';
  };
}
