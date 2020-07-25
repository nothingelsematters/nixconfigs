arg@{ config, pkgs, lib, ... }:

with config.lib;
let
  windows = import ./windows arg;
  layout = import ./layout arg;
  spotify = import ./spotify arg;
  monospaced = text:
    ''<span font_family="${theme.fonts.mono.name}">'' + text + "</span>";
in builtins.toJSON {
  height = constants.barHeight;

  layer = "top";
  position = "top";

  modules-left = [ "custom/apps" "custom/windows" "custom/spotify" ];
  modules-center = [ "clock" ];
  modules-right = [ "custom/layout" "pulseaudio" "cpu" "battery" "tray" ];

  "custom/apps" = {
    format = "";
    on-click = "${packages.launcher.cmd}";
    tooltip = false;
  };

  "custom/windows" = windows;

  "custom/spotify" = spotify;

  "custom/layout" = layout;

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
}
