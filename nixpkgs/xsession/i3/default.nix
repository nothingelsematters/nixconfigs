{ config, pkgs, ... }:

let
  modifier = "Mod4";
  theme    = import ../../themes { inherit pkgs; };
  mkOpaque = import ../../themes/lib/mkOpaque.nix;
  lock     = import ../../services/i3lock-fancy { inherit config; inherit pkgs; };

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

  home.packages = with pkgs; [ maim i3lock acpi ];

  xdg.configFile = {
    dunst_brightness = {
      executable = true;
      target = "i3/scripts/brightness";
      text = ''
      #!${pkgs.bash}/bin/bash

      CUT=${pkgs.coreutils}/bin/cut;
      SED=${pkgs.gnused}/bin/sed;
      SEQ=${pkgs.coreutils}/bin/seq;
      CAT=${pkgs.coreutils}/bin/cat;
      DUNSTIFY=${pkgs.notify-desktop}/bin/notify-desktop;

      # You can call this script like this:
      # $ ./brightnessControl.sh up
      # $ ./brightnessControl.sh down

      function get_brightness {
        $CAT /sys/class/backlight/intel_backlight/brightness
      }

      function send_notification {
        icon="preferences-system-brightness-lock"
        brightness=$(get_brightness)
        bar=$($SEQ -s "─" 0 $((brightness / 180)) | $SED 's/[0-9]//g')
        nl=$'\n'
        $DUNSTIFY -t 1000 -i "$icon" -r 5555 -u normal "$nl    $bar"
      }

      case $1 in
        up)
          echo $(expr $($CAT /sys/class/backlight/intel_backlight/brightness) + 100) > /sys/class/backlight/intel_backlight/brightness
          send_notification
          ;;
        down)
          echo $(expr $($CAT /sys/class/backlight/intel_backlight/brightness) - 100) > /sys/class/backlight/intel_backlight/brightness
          send_notification
          ;;
      esac
      '';
    };

    dunst_volume = {
      executable = true;
      target = "i3/scripts/volume";
      text = ''
      #!${pkgs.bash}/bin/bash

      AMIXER=${pkgs.alsaUtils}/bin/amixer;
      DUNSTIFY=${pkgs.notify-desktop}/bin/notify-desktop;
      GREP=${pkgs.ripgrep}/bin/rg;
      CUT=${pkgs.coreutils}/bin/cut;
      HEAD=head;

      # You can call this script like this:
      # $ ./volumeControl.sh up
      # $ ./volumeControl.sh down
      # $ ./volumeControl.sh mute

      function get_volume {
        $AMIXER get Master | $GREP '%' | $HEAD -n 1 | $CUT -d '[' -f 2 | $CUT -d '%' -f 1
      }

      function is_mute {
        $AMIXER get Master | $GREP '%' | $GREP -oe '[^ ]+$' | $GREP off > /dev/null
      }

      function send_notification {
        nl=$'\n'
        if is_mute ; then
          $DUNSTIFY -t 1000 -i "audio-volume-muted" -r 2593 -u normal "$nl mute"
        else
          volume=$(get_volume)
          bar=$(seq --separator="─" 0 "$((volume / 3))" | sed 's/[0-9]//g')

          if [[ $volume -lt 20 ]] ; then
            icon="audio-volume-low"
          fi

          if [[ $volume -ge 20 && $volume -lt 60 ]] ; then
            icon="audio-volume-medium"
          fi

          if [[ $volume -ge 60 ]] ; then
            icon="audio-volume-high"
          fi

          $DUNSTIFY -t 1000 -i $icon -r 2593 -u normal "$nl    $bar"
        fi
      }

      case $1 in
        up)
          $AMIXER set Master on > /dev/null
          $AMIXER sset Master 5%+ > /dev/null
          send_notification
          ;;
        down)
          $AMIXER set Master on > /dev/null
          $AMIXER sset Master 5%- > /dev/null
          send_notification
          ;;
        mute)
          $AMIXER set Master 1+ toggle > /dev/null
          send_notification
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
          "1" = [{ class = "TelegramDesktop"; }];
          "2" = [{ class = "Firefox"; }];
          "3" = [{ class = "Atom"; }];
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
            background  = "#ff00005a";
            border      = "#ff00005a";
            childBorder = "#0c0c0c";
            indicator   = "#ff000000";
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

          "${modifier}+Tab"         = "focus right";
          "${modifier}+Shift+Tab"   = "focus left";

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

          "${modifier}+w"           = "layout tabbed";
          "${modifier}+e"           = "layout toggle split";
          "${modifier}+Shift+space" = "floating toggle";

          "${modifier}+Shift+c"     = "reload";
          "${modifier}+Shift+r"     = "restart";
          "${modifier}+Shift+e"     = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
          "${modifier}+Return"      = "exec alacritty";
          "Menu"                    = "exec rofi -show";

          "Print"                      = "exec maim ~/Pictures/screenshots/$(date +\"%Y-%m-%d_%H:%M:%S\").png";
          "Control+Print"              = "exec maim | xclip -selection clipboard -t image/png";
          "${modifier}+Print"          = "exec maim -s ~/Pictures/screenshots/$(date +\"%Y-%m-%d_%H:%M:%S\").png";
          "${modifier}+Control+Print"  = "exec maim -s | xclip -selection clipboard -t image/png";

          "XF86AudioRaiseVolume"    = "exec ~/.config/i3/scripts/volume up";
          "XF86AudioLowerVolume"    = "exec ~/.config/i3/scripts/volume down";
          "XF86AudioMute"           = "exec ~/.config/i3/scripts/volume mute";

          "XF86MonBrightnessUp"     = "exec ~/.config/i3/scripts/brightness up";
          "XF86MonBrightnessDown"   = "exec ~/.config/i3/scripts/brightness down";

          "XF86PowerOff"            = "exec ${lock.services.screen-locker.lockCmd}";

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

        window.border = 0;

        startup = [
          { command = "systemctl --user restart polybar";    always = true; notification = false; }
          { command = "setxkbmap -layout us,ru";             always = true; notification = false; }
          { command = "setxkbmap -option 'grp:caps_toggle'"; always = true; notification = false; }
          { command = "telegram-desktop & disown";           always = true; notification = true; }
          { command = "libinput-gestures & disown";          always = true; notification = true; }
          { command = "echo 0";                              always = true; notification = false; }
        ];
      };
    };
  };
}
