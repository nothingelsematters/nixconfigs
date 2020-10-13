arg@{ config, pkgs, lib, ... }:

with config.lib;
with config.lib.theme.utils;
with builtins;
let
  modifier = "Mod4";
  scripts = import ./scripts arg;

  toKeybinding = buttons: value: {
    inherit value;
    name = "${modifier}+${buttons}";
  };

  numbersGenerator = sc: cmd: x:
    let str = toString x;
    in toKeybinding (sc + str) (cmd + str);
  withNumbers = sc: cmd:
    listToAttrs (tail (genList (numbersGenerator sc cmd) 7));

  dircGenerator = butt: cmd: d:
    toKeybinding (butt + lib.toUpper (substring 0 1 d) + substring 1 (-1) d)
    "${cmd} ${d}";
  withDirections = butt: cmd:
    listToAttrs (map (dircGenerator butt cmd) [ "left" "down" "up" "right" ]);

  kbdBrightness = flag:
    "exec ${pkgs.light}/bin/light -s sysfs/leds/asus::kbd_backlight"
    + " ${flag} 1 && ${pkgs.light}/bin/light -s sysfs/leds/asus::kbd_backlight"
    + " -G | cut -d'.' -f1 > $SWAYSOCK.wob";
  volume = flag:
    "exec ${pkgs.pamixer}/bin/pamixer ${flag} 2"
    + " && ${pkgs.pamixer}/bin/pamixer --get-volume > $SWAYSOCK.wob";
  monBrightness = flag:
    "exec ${pkgs.light}/bin/light ${flag} 3 &&"
    + " ${pkgs.light}/bin/light -G | cut -d'.' -f1 > $SWAYSOCK.wob";
in {
  home.packages = with pkgs; [ sway grim slurp wl-clipboard pamixer wob light ];

  # TODO cursor theme
  # BUG telegram from rofi (!): filepicker and notification

  systemd.user.services.inactive-transparency = {
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = scripts.inactive-transparency;
      Restart = "on-abort";
    };
  };

  wayland.windowManager.sway = {
    enable = true;

    config = {
      focus.followMouse = false;
      assigns = {
        "1" = [
          { app_id = "telegramdesktop"; }
          { class = "TelegramDesktop"; }
          { class = "Slack"; }
          { class = "Spotify"; }
        ];
        "2" = [{ class = "Firefox"; }];
        "3" = [{ class = "Typora"; }];
      };

      bars = [{
        command = "${config.programs.waybar.package}/bin/waybar";
        position = "top";
      }];

      startup = [
        { command = "kitty"; }
        { command = "firefox"; }
        {
          command = ''
            swayidle -w timeout 600 '${scripts.screen-lock}' \
              timeout 800 'swaymsg "output * dpms off"' \
              resume 'swaymsg "output * dpms on"' \
              before-sleep '${scripts.screen-lock}'
          '';
          always = true;
        }
      ];

      inherit modifier;
      fonts = [ "${theme.fonts.notification} 8" ];

      window.border = 0;
      floating = {
        inherit modifier;
        border = 0;
        criteria = [{ title = "Choose files"; }];
      };

      gaps = {
        inner = 6;
        outer = 2;
        smartBorders = "on";
      };

      input = {
        "type:keyboard" = {
          xkb_options = "grp:caps_toggle";
          xkb_layout = "us,ru";
        };
        "type:touchpad" = {
          click_method = "clickfinger";
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };

      colors = rec {
        focused = rec {
          background = theme.colors.background.primary;
          border = background;
          childBorder = theme.colors.background.accent;
          indicator = theme.colors.text.secondary;
          text = theme.colors.text.primary;
        };
        focusedInactive = rec {
          background = mkOpaque focused.background;
          border = background;
          childBorder = border;
          indicator = "#484e50";
          text = focused.text;
        };
        placeholder = {
          background = "#ff00005a";
          border = "#ff00005a";
          childBorder = "#0c0c0c";
          indicator = "#ff000000";
          text = "#ffffff";
        };
        unfocused = focusedInactive // {
          childBorder = theme.colors.background.primary;
          indicator = "#484e50";
        };
        urgent = placeholder;
      };

      bindkeysToCode = true;

      # TODO  win+tab floating support?
      # FIXME resize shortcut's broken
      keybindings = withDirections "Shift+" "move"
        // withNumbers "" "workspace "
        // withNumbers "Shift+" "move container to workspace "
        // withDirections "" "focus" // {
          "${modifier}+Tab" = "focus right";
          "${modifier}+Shift+Tab" = "focus left";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+Return" = "exec kitty";

          "${modifier}+Shift+q" = "kill";
          "${modifier}+r" = scripts.resize;

          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+s" = "sticky toggle";

          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";

          "${modifier}+F5" = "opacity minus 0.05";
          "${modifier}+F6" = "opacity plus  0.05";
          "${modifier}+F11" = "fullscreen";

          "Control+Space" = "exec ${pkgs.mako}/bin/makoctl dismiss";
          "Control+Shift+Space" = "exec ${pkgs.mako}/bin/makoctl dismiss -a";

          Menu = "exec ${packages.launcher.cmd}";

          Print = "exec grim - | wl-copy -o -t image/png";
          "Control+Print" = ''exec grim -g "$(slurp -b '#ffffff33' -c ''
            + '''${theme.colors.background.accent}ff')" ''
            + "- | wl-copy -o -t image/png";

          XF86KbdBrightnessUp = kbdBrightness "-A";
          XF86KbdBrightnessDown = kbdBrightness "-U";
          XF86MonBrightnessUp = monBrightness "-A";
          XF86MonBrightnessDown = monBrightness "-U";
          XF86AudioRaiseVolume = volume "-ui";
          XF86AudioLowerVolume = volume "-d";
          XF86AudioMute = "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute && "
            + "( ${pkgs.pamixer}/bin/pamixer --get-mute "
            + "&& echo 0 > $SWAYSOCK.wob ) || "
            + "${pkgs.pamixer}/bin/pamixer --get-volume > $SWAYSOCK.wob";
        };
    };

    extraConfig = ''
      seat seat0 xcursor_theme "Paper"
      seat * hide_cursor 1000
      focus_wrapping workspace
      for_window [title="Choose files"] resize width 700 height 550
      for_window [title="Choose files"] move center
      exec mkfifo $SWAYSOCK.wob && tail -f $SWAYSOCK.wob | ${pkgs.wob}/bin/wob -W 300 -H 25 -b 1 -o 1 -p 1 -a top -a right -M 20 -t 500
    '';
  };
}
