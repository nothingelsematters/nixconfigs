{ config, pkgs, lib, ... }:

let
  modifier = "Mod4";
  theme = import ../../theme { inherit pkgs lib; };
  mkOpaque = import ../../theme/lib/mkOpaque.nix;
  lock = import ../../services/i3lock-fancy {
    inherit config;
    inherit pkgs;
  };
  getScript = import ../../lib/getScript.nix { inherit pkgs lib; };
  getScript' = x: y: "exec " + getScript ./scripts x y;

  resizeScript = with pkgs;
    getScript' "resize.sh" [ [ slop "slop" ] [ i3-gaps "i3-msg" ] ];

  brightnessScript = with pkgs;
    getScript' "brightness.sh" [
      [ coreutils "cut" ]
      [ coreutils "seq" ]
      [ coreutils "cat" ]
      [ gnused "sed" ]
      [ notify-desktop "notify-desktop" ]
    ];

  volumeScript = with pkgs;
    getScript' "volume.sh" [
      [ alsaUtils "amixer" ]
      [ notify-desktop "notify-desktop" ]
      [ ripgrep "rg" ]
      [ coreutils "cut" ]
    ];
in rec {
  imports = [
    ../../programs/rofi
    ../../services/polybar
    ../../services/dunst
    ../../services/background
  ];

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
        modifier = modifier;
        fonts = [ "${theme.fonts.notification} 9" ];
        window.border = 0;

        floating = {
          modifier = modifier;
          border = 0;
          criteria = [ { title = "yad-calendar"; } { class = "Yad"; } ];
        };

        gaps = {
          inner = 10;
          outer = 8;
          smartBorders = "on";
        };

        startup = map (x: {
          command = x;
          always = true;
          notification = false;
        }) [
          "systemctl --user restart polybar"
          "telegram-desktop & disown"
          "libinput-gestures & disown"
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
            attr = buttons: cmd: {
              name = "${modifier}+${buttons}";
              value = cmd;
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

            "XF86AudioRaiseVolume" = volumeScript + " up";
            "XF86AudioLowerVolume" = volumeScript + " down";
            "XF86AudioMute" = volumeScript + " mute";

            "XF86MonBrightnessUp" = brightnessScript + " up";
            "XF86MonBrightnessDown" = brightnessScript + " down";

            "XF86PowerOff" = "exec ${lock.services.screen-locker.lockCmd}";

            "${modifier}+r" = resizeScript;
            "${modifier}+F11" = "fullscreen";
          };
      };
    };
  };
}
