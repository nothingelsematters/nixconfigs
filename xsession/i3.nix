{ config, pkgs, ... }:

let
  modifier = "Mod4";
  nord0    = "#2E3440";
  nord1    = "#3B4252";
  nord4    = "#D8DEE9";
  nord5    = "#E5E9F0";
  opaque   = "BF";
  theme    = import ../themes/nord.nix;
in

rec {
  imports = [
    ../programs/rofi.nix
    ../services/polybar.nix
    ../services/dunst.nix
    ../services/background.nix
  ];

  home.packages = [
    pkgs.maim # For screenshots
  ];

  xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-xresources";
      rev = "5a409ca2b4070d08e764a878ddccd7e1584f0096";
      sha256 = "1b775ilsxxkrvh4z8f978f26sdrih7g8w2pb86zfww8pnaaz403m";
    } + "/src/nord"
  );

  xdg.configFile.i3_audio_layout = {
    source = ./i3/layouts/audio.json;
    target = "i3/audio.json";
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
          $NOTIFY -i audio-volume-low -u normal -r 1337 -t 600 -c func "<span>$fullbar<span foreground=\"#4c566a\">$emptybar</span></span> $volume%"
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
      "1" = [{ class = "Firefox"; }];
      "2" = [{ title = "Atom"; } { class = "jetbrains"; }];
      "3" = [{ class = "TelegramDesktop"; } { class = "discrod"; }];
      "5" = [{ class = "Steam"; }];
    };

    bars = [];

    colors = rec {
      focused = {
        background  = theme.colors.primary;
        border      = theme.colors.primary; 
        childBorder = "${nord1}"; 
        indicator   = "#2e9ef4"; 
        text        = "${nord5}";
      };
      focusedInactive = {
        background  = theme.opaque.primary;
        border      = theme.opaque.primary;
        childBorder = theme.colors.primary;
        indicator   = "#484e50";
        text        = "${nord5}";
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
        childBorder = "${nord1}";
        indicator   = "#484e50";
        text        = "${nord4}";
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

      "${modifier}+a"           = ''workspace 6; append_layout ~/.config/i3/audio.json; exec glava; exec kitty --class=playlist -o font_size=20 -e ncmpcpp; exec kitty --class=music_library -o font_size=20 -e ncmpcpp -s media_library'';
      "${modifier}+f"           = "exec kitty -T=ranger ranger";
      "${modifier}+w"           = "layout tabbed";
      "${modifier}+e"           = "layout toggle split";
      "${modifier}+Shift+space" = "floating toggle";

      "${modifier}+Shift+c"     = "reload";
      "${modifier}+Shift+r"     = "restart";
      "${modifier}+Shift+e"     = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
      "${modifier}+Return"      = "exec kitty";
      "Menu"                    = "exec rofi -show";

      "Print"                   = "exec maim ~/Pictures/screenshots/$(date +\"%Y-%m-%d_%H:%M:%S\").png";
      "Control+Print"           = "exec maim | xclip -selection clipboard -t image/png";
      "${modifier}+Print"       = "exec maim -s ~/Pictures/screenshots/$(date +\"%Y-%m-%d_%H:%M:%S\").png";

      "XF86KbdBrightnessDown"   = "exec sudo sh -c \"echo $(expr $(cat /sys/class/leds/asus::kbd_backlight/brightness) - 1) > /sys/class/leds/asus::kbd_backlight/brightness\"";
      "XF86KbdBrightnessUp"     = "exec sudo sh -c \"echo $(expr $(cat /sys/class/leds/asus::kbd_backlight/brightness) + 1) > /sys/class/leds/asus::kbd_backlight/brightness\"";

      "XF86AudioRaiseVolume"    = "exec ~/.config/i3/scripts/volume up";
      "XF86AudioLowerVolume"    = "exec ~/.config/i3/scripts/volume down";
      "XF86AudioMute"           = "exec ~/.config/i3/scripts/volume mute";

      "${modifier}+r"           = "mode resize";

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
      commands = [
        { command = "border pixel 2";                   criteria = { class = "^.*"; };       }
        { command = "<span>[%instance] %title</span>";  criteria = { class = "^.*"; };       }
        { command = "border none";                      criteria = { class = "(Kitty|Alacritty|GLava)"; }; }
      ];
    };
    # https://github.com/rycee/home-manager/issues/213
    startup = [ { command = "systemctl --user restart polybar"; always = true; notification = false; } ];
  };
}
