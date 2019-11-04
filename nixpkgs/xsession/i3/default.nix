{ config, pkgs, ... }:

let
  modifier = "Mod4";
  theme    = import ../../themes;

  lock = pkgs.writeShellScriptBin "lock.sh" ''
    ${pkgs.maim}/bin/maim /tmp/lock_screenshot.jpg
    ${pkgs.imagemagick}/bin/convert /tmp/lock_screenshot.jpg -filter point -resize 10% -resize 1000% /tmp/lock_screenshot.png
    systemctl --user stop dunst
    ${pkgs.i3lock}/bin/i3lock -i /tmp/lock_screenshot.png
    systemctl --user start dunst
  '';

  mpdByTitle = pkgs.writeShellScriptBin "mpdByTitle.sh" ''

  JQ=${pkgs.jq}/bin/jq
  MPC=${pkgs.mpc_cli}/bin/mpc

  # function by Fikri Omar
  # https://github.com/fikriomar16/rofi-mpd/blob/master/rofi-mpd
  addaftercurrentandplay(){

        #playlist is empty, just add the song
        if [ "$($MPC playlist | wc -l)" == "0" ]; then
                $MPC add "$1"
                $MPC play

        #there is no current song so mpd is stopped
        #it seems to be impossible to determine the current songs' position when
        #mpd is stopped, so just add to the end
        elif [ -z "$($MPC current)" ]; then
                END_POS=$($MPC playlist | wc -l)
                $MPC add "$1"
                $MPC play $(($END_POS+1))

        #at least 1 song is in the playlist, determine the position of the
        #currently played song and add $1 after it
        else
                CUR_POS=$($MPC | tail -2 | head -1 | awk '{print $2}' | sed 's/#//' | awk -F/ '{print $1}')
                END_POS=$($MPC playlist | wc -l)
                $MPC add "$1"
                $MPC move $(($END_POS+1)) $(($CUR_POS+1))
                $MPC play $(($CUR_POS+1))
        fi
  }

  addalbum() {
    titles=("$@")
    IFS=$'\n' sorted=($(sort <<<"${"$"}{titles[*]}"))
    unset IFS
    addaftercurrentandplay ${"$"}{sorted[0]};
    COUNT=0;
    CUR_POS=$($MPC | tail -2 | head -1 | awk '{print $2}' | sed 's/#//' | awk -F/ '{print $1}')
    for i in "${"$"}{sorted[@]:1}"
    do
      END_POS=$($MPC playlist | wc -l)
      $MPC add "$i"
      $MPC move $(($END_POS+1)) $(($CUR_POS+1+$COUNT))
      COUNT=$(($COUNT+1))
    done
  }

  case $1 in
    track)
      title=$(gzip -d -c ~/.local/share/mopidy/local/library.json.gz | $JQ -r ".tracks[] | .name + \" <small>(\"  + .artists[0].name + \", \" + .album.name + \")</small>\" " | sort | rofi -dmenu -markup-rows -matching normal -i | sed 's/<small>.*//' | xargs -I % $MPC find Title "%" | cut -d " " -f1)
      if [ "$title" ]; then
        addaftercurrentandplay $title;
      fi
      ;;
    album)
      titles=$(gzip -d -c ~/.local/share/mopidy/local/library.json.gz | $JQ -r ".tracks[].album | .name + \" <small>(\" + .artists[0].name + \")</small>\"" | sort | uniq | rofi -dmenu -markup-rows -matching normal -i | sed 's/<small>.*//' | xargs -I % $MPC find Album "%")
      if [ "$titles" ]; then
        addalbum $titles;
      fi
      ;;
    *)
  esac

  '';
in

rec {
  imports = [
    ../../programs/rofi
    ../../services/polybar
    ../../services/dunst
    ../../services/background
  ];

  home.packages = [
    pkgs.maim # For screenshotstrue
    pkgs.i3lock
    pkgs.flashfocus
  ];

  # TODO why here?..
  xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-xresources";
      rev = "5a409ca2b4070d08e764a878ddccd7e1584f0096";
      sha256 = "1b775ilsxxkrvh4z8f978f26sdrih7g8w2pb86zfww8pnaaz403m";
    } + "/src/nord"
  );

  /* xdg.configFile.i3_audio_layout = {
    source = ./layouts/audio.json;
    target = "i3/audio.json";
  }; */

  xdg.configFile.flashfocus = {
    source = ./flashfocus.yml;
    target = "flashfocus/flashfocus.yml";
  };

  xdg.configFile.dunst_volume = {
    executable = true;
    target = "i3/scripts/volume";
    text = ''
      #!${pkgs.bash}/bin/bash

      PACTL=${pkgs.pulseaudio}/bin/pactl;
      AWK=${pkgs.gawk}/bin/awk;
      NOTIFY=${pkgs.notify-desktop}/bin/notify-desktop;

      function get_volume {
        $PACTL list sinks | $AWK '/^[\t]+Volume/ {print ($5 + $12) / 2}'
      }

      function is_mute {
        $PACTL list sinks | $AWK '/^[\t]+Mute/ { print $2 }' | grep yes > /dev/null
      }

      function notify {
          volume=`get_volume`
          third_volume=$((`get_volume` / 3))
          # third_volume=max(third_volume, 33)
          third_volume=$(( third_volume < 33 ? third_volume : 33))
          fullbar=$(seq -s "─" $((third_volume + 1)) | sed 's/[0-9]//g')
          emptybar=$(seq -s "─" $((33 - third_volume + 1)) | sed 's/[0-9]//g')
          # Send the notification
          if is_mute; then
            icon=audio-volume-low
          else
            icon=audio-volume-muted
          fi
          $NOTIFY -i $icon -u normal -r 1337 -t 600 -c func "Volume" "$fullbar<span foreground=\"#4c566a\">$emptybar</span> $volume%"
      }

      case $1 in
          up)
            $PACTL set-sink-volume @DEFAULT_SINK@ +3%
            notify
            ;;
          down)
            $PACTL set-sink-volume @DEFAULT_SINK@ -3%
            notify
            ;;
          mute)
            $PACTL set-sink-mute @DEFAULT_SINK@ toggle
            if is_mute ; then
              $NOTIFY -c func -t 600 -i audio-volume-muted -r 1337 -u normal "Mute"
            else
              notify
            fi
            ;;
      esac
      '';
  };

  xsession.pointerCursor = {
    package = pkgs.paper-icon-theme;
    name = "Paper";
    size = 16;
  };

  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config = {
    assigns = {
      "1" = [{ class = "Firefox"; } { class = "Chromium-browser"; } { class = "Deluge"; }];
      "2" = [{ title = "Atom"; } { class = "jetbrains"; } { class = "Emacs"; }];
      "3" = [{ class = "TelegramDesktop"; } { class = "discord"; } { class = "Keybase"; }];
      "5" = [{ class = "Steam"; } { class = "wesnoth"; } { class = "xonotic-(glx|sdl)"; }];
    };

    bars = [];

    colors = rec {
      focused = {
        background  = theme.colors.primary;
        border      = theme.colors.primary;
        childBorder = "${theme.colors.accent}";
        indicator   = "#2e9ef4";
        text        = "${theme.colors.text}";
      };
      focusedInactive = {
        background  = theme.opaque.primary;
        border      = theme.opaque.primary;
        childBorder = theme.colors.primary;
        indicator   = "#484e50";
        text        = "${theme.colors.text}";
      };
      placeholder = {
        background  = "#0000005a";
        border      = "#0000005a";
        childBorder = "#0c0c0c";
        indicator   = "#000000";
        text        = "#ffffff";
      };
      unfocused = {
        background  = theme.opaque.primary;
        border      = theme.opaque.primary;
        childBorder = "${theme.colors.accent}";
        indicator   = "#484e50";
        text        = "${theme.colors.text}";
      };
      urgent = placeholder;
    };

    modifier = modifier;
    floating.modifier = modifier;

    gaps = {
      inner = 10;
      smartGaps = true;
      smartBorders = "on";
    };

    fonts = [ "Fira Code 10" ];

    keybindings = {
      "${modifier}+Shift+q" = "kill";

      "${modifier}+Left"        = "focus left";
      "${modifier}+Down"        = "focus down";
      "${modifier}+Up"          = "focus up";
      "${modifier}+Right"       = "focus right";
      "${modifier}+Shift+Left"  = "move left";
      "${modifier}+Shift+Down"  = "move down";
      "${modifier}+Shift+Up"    = "move up";
      "${modifier}+Shift+Right" = "move right";

      "${modifier}+h"           = "focus left";
      "${modifier}+j"           = "focus down";
      "${modifier}+k"           = "focus up";
      "${modifier}+l"           = "focus right";
      "${modifier}+Tab"         = "focus right";
      "${modifier}+Shift+Tab"   = "focus left";
      "${modifier}+Shift+h"     = "move left";
      "${modifier}+Shift+j"     = "move down";
      "${modifier}+Shift+k"     = "move up";
      "${modifier}+Shift+l"     = "move right";

      "${modifier}+1"           = "workspace 1";
      "${modifier}+2"           = "workspace 2";
      "${modifier}+3"           = "workspace 3";
      "${modifier}+4"           = "workspace 4";
      "${modifier}+5"           = "workspace 5";
      "${modifier}+6"           = "workspace 6";
      "${modifier}+grave"       = "workspace 7";
      "${modifier}+Shift+1"     = "move container to workspace 1";
      "${modifier}+Shift+2"     = "move container to workspace 2";
      "${modifier}+Shift+3"     = "move container to workspace 3";
      "${modifier}+Shift+4"     = "move container to workspace 4";
      "${modifier}+Shift+5"     = "move container to workspace 5";
      "${modifier}+Shift+6"     = "move container to workspace 6";
      "${modifier}+Shift+grave" = "move container to workspace 7";

      "${modifier}+f"           = "exec kitty -T=lf lf";
      "${modifier}+w"           = "layout tabbed";
      "${modifier}+e"           = "layout toggle split";
      "${modifier}+Shift+space" = "floating toggle";

      "${modifier}+Shift+c"     = "reload";
      "${modifier}+Shift+r"     = "restart";
      "${modifier}+Shift+e"     = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
      "${modifier}+Return"      = "exec kitty";
      "Menu"                    = "exec rofi -show";

      "Print"                      = "exec maim ~/Pictures/screenshots/$(date +\"%Y-%m-%d_%H:%M:%S\").png";
      "Control+Print"              = "exec maim | xclip -selection clipboard -t image/png";
      "${modifier}+Print"          = "exec maim -s ~/Pictures/screenshots/$(date +\"%Y-%m-%d_%H:%M:%S\").png";
      "${modifier}+Control+Print"  = "exec maim -s | xclip -selection clipboard -t image/png";

      "XF86KbdBrightnessDown"   = "exec echo $(expr $(cat /sys/class/leds/asus::kbd_backlight/brightness) - 1) > /sys/class/leds/asus::kbd_backlight/brightness";
      "XF86KbdBrightnessUp"     = "exec echo $(expr $(cat /sys/class/leds/asus::kbd_backlight/brightness) + 1) > /sys/class/leds/asus::kbd_backlight/brightness";

      "${modifier}+F3"          = "exec echo $(expr $(cat /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1) - 3) > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1";
      "${modifier}+F4"          = "exec echo $(expr $(cat /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1) + 3) > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1";
      "${modifier}+F2"          = "exec echo $([[ $(cat /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1_enable) = 2 ]] && echo 1 || echo 2) > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1_enable";

      "XF86AudioRaiseVolume"    = "exec ~/.config/i3/scripts/volume up";
      "XF86AudioLowerVolume"    = "exec ~/.config/i3/scripts/volume down";
      "XF86AudioMute"           = "exec ~/.config/i3/scripts/volume mute";

      "XF86MonBrightnessDown"   = "exec echo $(expr $(cat /sys/class/backlight/intel_backlight/brightness) - 10) > /sys/class/backlight/intel_backlight/brightness";
      "XF86MonBrightnessUp"     = "exec echo $(expr $(cat /sys/class/backlight/intel_backlight/brightness) + 10) > /sys/class/backlight/intel_backlight/brightness";

      "XF86PowerOff"            = "exec ${lock}/bin/lock.sh";

      "${modifier}+r"           = "mode resize";

      "${modifier}+F11"         = "fullscreen";

      "${modifier}+m"           = "exec ${mpdByTitle}/bin/mpdByTitle.sh track";
      "${modifier}+a"           = "exec ${mpdByTitle}/bin/mpdByTitle.sh album";
    };

    modes = {
          resize = {
                 h      = "resize shrink width 10 px or 10 ppt";
                 j      = "resize grow height 10 px or 10 ppt";
                 k      = "resize shrink height 10 px or 10 ppt";
                 l      = "resize grow width 10 px or 10 ppt";
                 Return = "mode default";
                 Escape = "mode default";
          };
    };

    window = {
      commands = [
        { command = "border pixel 2";                   criteria = { class = "^.*"; };       }
        { command = "<span>[%instance] %title</span>";  criteria = { class = "^.*"; };       }
        { command = "border none";                      criteria = { class = "(Kitty|Alacritty|GLava)"; }; }
      ];
    };
    # https://github.com/rycee/home-manager/issues/213
    startup = [
      { command = "systemctl --user restart polybar"; always = true; notification = false; }
      { command = "flashfocus"; always = true; notification = false; }
      { command = "echo 0"; always = true; notification = false; }
    ];
  };
}
