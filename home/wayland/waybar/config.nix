arg@{ config, pkgs, ... }:

with config.lib;
let
  monospaced = text:
    ''<span font_family="${theme.fonts.mono.name}">'' + text + "</span>";
in {
  programs.waybar.settings = [{
    height = constants.barHeight;

    layer = "top";
    position = "top";

    modules-left = [ "custom/apps" "custom/windows" "custom/spotify" ];
    modules-center = [ "clock" ];
    modules-right = [ "custom/layout" "pulseaudio" "cpu" "battery" "tray" ];

    modules = {
      "custom/apps" = {
        format = "";
        on-click = packages.launcher.cmd;
        tooltip = false;
      };

      "custom/windows" = import ./windows arg;
      "custom/spotify" = import ./spotify arg;
      "custom/layout" = import ./layout arg;

      pulseaudio = {
        format = "{icon} ${monospaced "{volume}"}%";
        format-bluetooth = "{icon} [{desc}] ${monospaced "{volume}"}%";
        format-muted = " mute";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" ];
        };
        scroll-step = 1;
        on-click =
          config.wayland.windowManager.sway.config.keybindings.XF86AudioMute;
        tooltip = false;
      };

      cpu = {
        interval = 3;
        format = " ${monospaced "{usage}"}%";
        max-length = 10;
        tooltip = false;
        on-click = "kitty htop &";
      };

      battery = {
        format = "{icon} ${monospaced "{capacity}"}%";
        interval = 5;
        states = {
          warning = 20;
          critical = 10;
        };
        format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
      };

      tray = {
        icon-size = 16;
        spacing = 0;
      };
    };
  }];
}
