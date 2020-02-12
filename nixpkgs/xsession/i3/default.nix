{ config, pkgs, lib, ... }:

let
  modifier = "Mod4";
  theme    = import ../../theme { inherit pkgs; };
  mkOpaque = import ../../theme/lib/mkOpaque.nix;
  lock     = import ../../services/i3lock-fancy { inherit config; inherit pkgs; };

  getScript = with builtins; name: packs:
    let
      fst = x: elemAt x 0;
      snd = x: elemAt x 1;
      replacing = replaceStrings [ "-" ] [ "" ];
      patching = x: "${lib.toUpper (replacing (snd x))}=${fst x}/bin/${snd x}";
      patchPkgs = file: packs: concatStringsSep "\n" (map patching packs) + "\n" + readFile file;
    in
      (pkgs.writeShellScriptBin name (patchPkgs (./scripts + ("/" + name)) packs)) + "/bin/" + name;

  resizeScript = with pkgs; getScript "resize.sh" [
    [ slop "slop" ]
    [ i3-gaps "i3-msg" ]
  ];

  brightnessScript = with pkgs; getScript "brightness.sh" [
    [ coreutils "cut" ]
    [ coreutils "seq" ]
    [ coreutils "cat" ]
    [ gnused "sed" ]
    [ notify-desktop "notify-desktop" ]
  ];

  volumeScript = with pkgs; getScript "volume.sh" [
    [ alsaUtils "amixer" ]
    [ notify-desktop "notify-desktop" ]
    [ ripgrep "rg" ]
    [ coreutils "cut" ]
  ];
in

rec {
  imports = [
    ../../programs/rofi
    ../../services/polybar
    ../../services/dunst
    ../../services/background
  ];

  home.packages = with pkgs; [ maim acpi ];

  xsession = {
    pointerCursor = theme.cursor;

    windowManager.i3 ={
      enable = true;

      config = {
        focus.followMouse = false;

        assigns = {
          "1" = [{ class = "TelegramDesktop"; } { class = "Slack"; }];
          "2" = [{ class = "Firefox"; }];
          "3" = [{ class = "Atom"; } { class = "Typora"; }];
        };

        bars = [];

        modifier = modifier;

        fonts = [ "${theme.fonts.notification} 9" ];

        window.border = 0;

        floating = {
          modifier = modifier;
          criteria = [
            { title = "yad-calendar"; }
            { class = "Yad"; }
          ];
        };

        gaps = {
          inner = 10;
          outer = 20;
          smartBorders = "on";
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

        startup = [
          { command = "systemctl --user restart polybar"; always = true; notification = false; }
          { command = "telegram-desktop & disown";        always = true; notification = false; }
          { command = "libinput-gestures & disown";       always = true; notification = false; }
          { command = "echo 0";                           always = true; notification = false; }
        ];

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

          "Print"                   = "exec maim -u | xclip -selection clipboard -t image/png";
          "Control+Print"           = "exec maim -s -u | xclip -selection clipboard -t image/png";

          "XF86AudioRaiseVolume"    = "exec ${volumeScript} up";
          "XF86AudioLowerVolume"    = "exec ${volumeScript} down";
          "XF86AudioMute"           = "exec ${volumeScript} mute";

          "XF86MonBrightnessUp"     = "exec ${brightnessScript} up";
          "XF86MonBrightnessDown"   = "exec ${brightnessScript} down";

          "XF86PowerOff"            = "exec ${lock.services.screen-locker.lockCmd}";

          "${modifier}+r"           = "exec ${resizeScript}";
          "${modifier}+F11"         = "fullscreen";
        };
      };
    };
  };
}
