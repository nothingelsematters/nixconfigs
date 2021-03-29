arg@{ config, pkgs, lib, ... }:

with config.lib;
with theme.utils;
with builtins;
let scripts = import ./scripts arg;
in {
  imports = [ ./keybindings.nix ];

  home.packages = with pkgs; [ sway grim ];

  # TODO cursor theme
  systemd.user.services.inactive-transparency = {
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = scripts.inactive-transparency;
      Restart = "on-abort";
    };
  };

  wayland.windowManager.sway = {
    enable = true;

    config = rec {
      focus.followMouse = false;
      assigns = {
        "1" = [
          { app_id = "telegramdesktop"; }
          { class = "TelegramDesktop"; }
          { class = "Slack"; }
          { class = "Spotify"; }
        ];
        "2" = [{ class = "Firefox"; }];
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

      modifier = "Mod4";
      fonts = [ "${theme.fonts.notification} 8" ];

      window = {
        border = 0;
        commands = let
          titles = [ "Choose files" "Open File" ];
          commands =
            [ "resize width 700 height 550" "move center" "border pixel 1" ];
        in concatLists (map (command:
          map (title: {
            inherit command;
            criteria = { inherit title; };
          }) titles) commands);
      };

      floating = {
        inherit modifier;
        border = 0;
        criteria = [ { title = "Choose files"; } { title = "Open File"; } ];
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
    };

    extraConfig = ''
      seat seat0 xcursor_theme "Paper"
      seat * hide_cursor 1000
      focus_wrapping workspace
      exec mkfifo $SWAYSOCK.wob && tail -f $SWAYSOCK.wob | ${pkgs.wob}/bin/wob -W 300 -H 25 -b 1 -o 1 -p 1 -a top -a right -M 20 -t 500
    '';
  };
}
