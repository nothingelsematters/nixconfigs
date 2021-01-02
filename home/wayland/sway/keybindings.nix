arg@{ config, pkgs, lib, ... }:

with config.lib;
with builtins;
let
  modifier = config.wayland.windowManager.sway.config.modifier;
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
  home.packages = with pkgs; [ slurp wl-clipboard pamixer wob light ];

  wayland.windowManager.sway.config = {
    bindkeysToCode = true;

    # TODO  win+tab floating support?
    # FIXME resize shortcut's broken
    keybindings = let
      copyScreenshot = "wl-copy -o -t image/png "
        + "&& ${pkgs.notify-desktop}/bin/notify-desktop "
        + ''"Screenshot has been captured" -i gnome-screenshot'';
    in withDirections "Shift+" "move" // withNumbers "" "workspace "
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

      Print = "exec grim - | ${copyScreenshot}";
      "Control+Print" = ''exec grim -g "$(slurp -b '#ffffff33' -c ''
        + '''${theme.colors.background.accent}ff')" - | ${copyScreenshot}'';

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
}
