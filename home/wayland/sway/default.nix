{ config, pkgs, lib, ... }:

let
  modifier = "Mod4";
  vars = import ../../lib { inherit pkgs; };
  theme = import ../../theme { inherit pkgs lib; };
  mkOpaque = import ../../lib/theme/mkOpaque.nix;

  scripts = import ./scripts { inherit pkgs; };
  waybar = (pkgs.waybar.override { pulseSupport = true; });

  codeBind = keybindings:
    builtins.concatStringsSep "\n" (pkgs.lib.attrsets.mapAttrsToList
      (bind: cmd: "bindsym --to-code ${bind} ${cmd}") keybindings);
in rec {
  imports = [ ../../programs/rofi ../../services/sway ];

  home = {
    packages = with pkgs; [
      waybar
      sway
      # TODO swaylock-fancy
      grim
      slurp
      wl-clipboard
      pamixer
      wob
      light
    ];

    # TODO fix
    sessionVariables.XCURSOR_PATH = theme.cursor.package;
  };

  # TODO volume and brightness bars
  # TODO shadows

  systemd.user.services.inactive-transparency = {
    Install = { WantedBy = [ "graphical-session.target" ]; };
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
        "1" = [ { app_id = "telegramdesktop"; } { class = "Slack"; } ];
        "2" = [{ class = "Firefox"; }];
        "3" = [ { class = "Atom"; } { class = "Typora"; } ];
      };

      bars = [{
        command = "${waybar}/bin/waybar";
        position = "top";
      }];

      startup =
        map (val: { command = val; }) [ "libinput-gestures" "kitty" "firefox" ];

      modifier = modifier;
      fonts = [ "${theme.fonts.notification} 9" ];

      window.border = 0;
      floating = {
        modifier = modifier;
        border = 0;
        criteria =
          [{ title = "Choose files"; }]; # telegram shitty file-piker fix
      };

      gaps = {
        inner = 10;
        outer = 8;
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

          kbdBrightness = flag:
            "exec ${pkgs.light}/bin/light -s sysfs/leds/asus::kbd_backlight ${flag} 1 && "
            + "${pkgs.light}/bin/light -s sysfs/leds/asus::kbd_backlight -G | cut -d'.' -f1 > $SWAYSOCK.wob";
          volume = flag:
            "exec ${pkgs.pamixer}/bin/pamixer ${flag} 2 && ${pkgs.pamixer}/bin/pamixer --get-volume > $SWAYSOCK.wob";
          monBrightness = flag:
            "exec ${pkgs.light}/bin/light ${flag} 3 && ${pkgs.light}/bin/light -G | cut -d'.' -f1 > $SWAYSOCK.wob";

        in withNumbers "" "workspace "
        // withNumbers "Shift+" "move container to workspace "
        // withDirections "" "focus" // withDirections "Shift+" "move" // {
          "${modifier}+Tab" = "focus left";
          "${modifier}+Shift+Tab" = "focus right";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+Return" = "exec kitty";
          Menu = "exec rofi -show";

          Print = "exec grim - | wl-copy -o -t image/png";
          "Control+Print" = ''
            exec grim -g "$(slurp -b '#ffffff00' -c '${theme.colors.background.accent}ff')" - | wl-copy -o -t image/png'';

          "${modifier}+F11" = "fullscreen";

          XF86KbdBrightnessUp = kbdBrightness "-A";
          XF86KbdBrightnessDown = kbdBrightness "-U";
          XF86MonBrightnessUp = monBrightness "-A";
          XF86MonBrightnessDown = monBrightness "-U";
          XF86AudioRaiseVolume = volume "-ui";
          XF86AudioLowerVolume = volume "-d";
          XF86AudioMute = vars.toggle-mute;

          "${modifier}+F5" = "opacity minus 0.05";
          "${modifier}+F6" = "opacity plus  0.05";

          # TODO does that shit even work?
          XF86PowerOff = "exec ${config.services.screen-locker.lockCmd}";
        };
    };

    extraConfig = let
      codeKeybindings = {
        "${modifier}+Shift+q" = "kill";
        "${modifier}+r" = scripts.resize;

        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+s" = "sticky toggle";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" =
          "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

        "Control+Space" = "exec ${pkgs.mako}/bin/makoctl dismiss";
        "Control+Shift+Space" = "exec ${pkgs.mako}/bin/makoctl dismiss -a";
      };
    in ''
      focus_wrapping workspace
      for_window [title="Choose files"] resize width 900 height 550
      for_window [title="Choose files"] move center
      exec mkfifo $SWAYSOCK.wob && tail -f $SWAYSOCK.wob | ${pkgs.wob}/bin/wob -a bottom -M 40 -t 500
      ${codeBind codeKeybindings}
    '';
  };
}
