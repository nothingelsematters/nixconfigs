arg@{ config, pkgs, lib, ... }:

with config.lib;
with config.lib.theme.utils;
let
  lock = import ../../services/screen-locker arg;
  scripts = import ./scripts arg;
  modifier = "Mod4";
in rec {
  imports = [ ../../programs/rofi ];

  home.packages = with pkgs; [ maim acpi ];

  xsession = {
    pointerCursor = theme.cursor;

    windowManager.i3 = {
      enable = true;

      config = {
        focus.followMouse = false;
        assigns = {
          "1" = [ { class = "TelegramDesktop"; } { class = "Slack"; } ];
          "2" = [{ class = "Firefox"; }];
          "3" = [ { class = "Atom"; } { class = "Typora"; } ];
        };

        bars = [ ];
        inherit modifier;
        fonts = [ "${theme.fonts.notification} 9" ];
        window.border = 0;

        floating = {
          inherit modifier;
          border = 0;
          criteria = [ { title = "yad-calendar"; } { class = "Yad"; } ];
        };

        gaps = {
          inner = 10;
          outer = 8;
          smartBorders = "on";
        };

        startup = map (command: {
          inherit command;
          always = true;
          notification = false;
        }) [
          "systemctl --user restart polybar"
          "libinput-gestures & disown"
          "telegram-desktop & disown"
          "kitty & disown"
          "firefox & disown"
          "echo 0"
        ];

        colors = rec {
          focused = {
            background = theme.colors.background.primary;
            border = theme.colors.background.primary;
            childBorder = theme.colors.background.accent;
            indicator = theme.colors.text.secondary;
            text = theme.colors.text.primary;
          };
          focusedInactive = {
            background = mkOpaque theme.colors.background.primary;
            border = mkOpaque theme.colors.background.primary;
            childBorder = mkOpaque theme.colors.background.primary;
            indicator = "#484e50";
            text = theme.colors.text.primary;
          };
          placeholder = {
            background = "#ff00005a";
            border = "#ff00005a";
            childBorder = "#0c0c0c";
            indicator = "#ff000000";
            text = "#ffffff";
          };
          unfocused = {
            background = mkOpaque theme.colors.background.primary;
            border = mkOpaque theme.colors.background.primary;
            childBorder = theme.colors.background.primary;
            indicator = "#484e50";
            text = theme.colors.text.primary;
          };
          urgent = placeholder;
        };

        keybindings = with builtins;
          let
            attr = buttons: value: {
              inherit value;
              name = "${modifier}+${buttons}";
            };

            numbersGenerator = sc: cmd: x:
              let str = toString x;
              in attr (sc + str) (cmd + str);
            withNumbers = sc: cmd:
              listToAttrs (tail (genList (numbersGenerator sc cmd) 7));

            dircGenerator = butt: cmd: d:
              attr (butt + lib.toUpper (substring 0 1 d)
                + substring 1 (stringLength d - 1) d) "${cmd} ${d}";
            withDirections = butt: cmd:
              listToAttrs
              (map (dircGenerator butt cmd) [ "left" "down" "up" "right" ]);

            screenshot = flags:
              "exec maim -u ${flags} | xclip -selection clipboard -t image/png";
          in withNumbers "" "workspace"
          // withNumbers "Shift+" "move container to workspace"
          // withDirections "" "focus" // withDirections "Shift+" "move" // {
            "${modifier}+Shift+q" = "kill";

            "${modifier}+Tab" = "focus right";
            "${modifier}+Shift+Tab" = "focus left";

            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";
            "${modifier}+Shift+space" = "floating toggle";

            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+r" = "restart";
            "${modifier}+Shift+e" =
              "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
            "${modifier}+Return" = "exec kitty";
            "Menu" = "exec rofi -show";

            "Print" = screenshot "";
            "Control+Print" = screenshot "-s";

            "XF86AudioRaiseVolume" = scripts.volume + " up";
            "XF86AudioLowerVolume" = scripts.volume + " down";
            "XF86AudioMute" = scripts.volume + " mute";

            "XF86MonBrightnessUp" = scripts.brightness + " up";
            "XF86MonBrightnessDown" = scripts.brightness + " down";

            "XF86PowerOff" = "exec ${lock.services.screen-locker.lockCmd}";

            "${modifier}+r" = scripts.resize;
            "${modifier}+F11" = "fullscreen";
          };
      };
    };
  };
}
