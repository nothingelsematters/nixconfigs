{ config, pkgs, ... }:

let
  modifier = "Mod4";
  theme    = import ../../themes { inherit pkgs; };
  mkOpaque = import ../../themes/lib/mkOpaque.nix;

  lock = pkgs.writeShellScriptBin "lock.sh" ''
    ${pkgs.maim}/bin/maim /tmp/lock_screenshot.jpg
    ${pkgs.imagemagick}/bin/convert /tmp/lock_screenshot.jpg -filter point -resize 10% -resize 1000% /tmp/lock_screenshot.png
    systemctl --user stop dunst
    ${pkgs.i3lock}/bin/i3lock -i /tmp/lock_screenshot.png
    systemctl --user start dunst
  '';

  graphical_resize = pkgs.writeShellScriptBin "resize.sh" ''
    SLOP=${pkgs.slop}/bin/slop
    I3MSG=${pkgs.i3-gaps}/bin/i3-msg

    $I3MSG mark __moving

    read -r X Y W H G ID < <($SLOP -f '%x %y %w %h %g %i')

    if [ -z "$X" ]; then
      $I3MSG unmark __moving
      exit;
    fi;

    $I3MSG [con_mark="__moving"] floating enable
    $I3MSG [con_mark="__moving"] move position $X $Y

    if [ "$W" -eq "0" ]; then
      $I3MSG unmark __moving
      exit;
    fi;

    $I3MSG [con_mark="__moving"] resize set $W $H
    $I3MSG unmark __moving
  '';
in

rec {
  imports = [
    ../../programs/rofi
    ../../services/polybar
    ../../services/dunst
    ../../services/background
  ];

  home.packages = with pkgs; [ maim i3lock flashfocus ];

  xdg.configFile = {
    flashfocus = {
      source = ./flashfocus.yml;
      target = "flashfocus/flashfocus.yml";
    };

    dunst_volume = {
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
  };

  xsession = {
    pointerCursor = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
      size = 15;
    };

    windowManager.i3 ={
      enable = true;

      config = {
        focus.followMouse = false;

        assigns = {
          "1" = [{ class = "Firefox"; }];
          "2" = [{ class = "Atom"; }];
          "3" = [{ class = "TelegramDesktop"; }];
        };

        bars = [];

        colors = rec {
          focused = {
            background  = theme.colors.background.primary;
            border      = theme.colors.background.primary;
            childBorder = theme.colors.background.accent;
            indicator   = "#2e9ef4";  # TODO
            text        = theme.colors.text.primary;
          };
          focusedInactive = {
            background  = mkOpaque theme.colors.background.primary;
            border      = mkOpaque theme.colors.background.primary;
            childBorder = mkOpaque theme.colors.background.primary;
            indicator   = "#484e50";
            text        = theme.colors.text.primary;
          };
          placeholder = {
            background  = "#0000005a";
            border      = "#0000005a";
            childBorder = "#0c0c0c";
            indicator   = "#000000";
            text        = "#ffffff";
          };
          unfocused = {
            background  = mkOpaque theme.colors.background.primary;
            border      = mkOpaque theme.colors.background.primary;
            childBorder = theme.colors.background.primary;
            indicator   = "#484e50";
            text        = theme.colors.text.primary;
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

        fonts = [ "Ubuntu Regular 9.6" ];

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

          "${modifier}+F3"          = "exec echo $(expr $(cat /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1) - 3) > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1";
          "${modifier}+F4"          = "exec echo $(expr $(cat /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1) + 3) > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1";
          "${modifier}+F2"          = "exec echo $([[ $(cat /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1_enable) = 2 ]] && echo 1 || echo 2) > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon3/pwm1_enable";

          "XF86AudioRaiseVolume"    = "exec ~/.config/i3/scripts/volume up";
          "XF86AudioLowerVolume"    = "exec ~/.config/i3/scripts/volume down";
          "XF86AudioMute"           = "exec ~/.config/i3/scripts/volume mute";

          "XF86MonBrightnessDown"   = "exec echo $(expr $(cat /sys/class/backlight/intel_backlight/brightness) - 100) > /sys/class/backlight/intel_backlight/brightness";
          "XF86MonBrightnessUp"     = "exec echo $(expr $(cat /sys/class/backlight/intel_backlight/brightness) + 100) > /sys/class/backlight/intel_backlight/brightness";

          "XF86PowerOff"            = "exec ${lock}/bin/lock.sh";

          "${modifier}+r"           = "exec ${graphical_resize}/bin/resize.sh";
          "${modifier}+F11"         = "fullscreen";
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
          border = 2;

          commands = [
            { command = "border pixel 2";                   criteria = { class = "^.*"; };       }
            { command = "<span>[%instance] %title</span>";  criteria = { class = "^.*"; };       }
            { command = "border pixel 1";                   criteria = { class = "(Kitty|Alacritty|GLava)"; }; }
          ];
        };

        startup = [
          { command = "systemctl --user restart polybar";    always = true; notification = false; }
          { command = "guake";                               always = true; notification = true; }
          { command = "setxkbmap -layout us,ru";             always = true; notification = false; }
          { command = "setxkbmap -option 'grp:caps_toggle'"; always = true; notification = false; }
          { command = "telegram-desktop & disown";           always = true; notification = true; }
          { command = "libinput-gestures & disown";          always = true; notification = true; }
          { command = "flashfocus";                          always = true; notification = false; }
          { command = "echo 0";                              always = true; notification = false; }
        ];
      };
    };
  };
}
