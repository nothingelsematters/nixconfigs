arg@{ config, pkgs, lib, ... }:

with config.lib;
let
  windows = import ./windows arg;
  layout = import ./layout arg;
  monospaced = text:
    ''<span font_family="${theme.fonts.mono.name}">'' + text + "</span>";
in builtins.toJSON {
  height = constants.barHeight;

  layer = "bottom";
  position = "top";

  modules-left = [ "custom/apps" "custom/windows" "sway/window" ];
  modules-center = [ "clock" ];
  modules-right = [ "custom/layout" "pulseaudio" "cpu" "network" "battery" ];

  "custom/apps" = {
    format = "";
    on-click = "${packages.launcher.cmd}";
    tooltip = false;
  };

  "custom/windows" = windows;

  "sway/window" = {
    format = "{}";
    max-length = 70;
    tooltip = false;
  };

  "custom/layout" = layout;

  pulseaudio = {
    format = "{icon} {volume}%";
    format-bluetooth = "{icon} [{desc}] {volume}%";
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
    on-click = constants.toggleMute;
    tooltip = false;
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

  cpu = {
    interval = 3;
    format = " ${monospaced "{usage}"}%";
    max-length = 10;
    tooltip = false;
    on-click = "kitty htop &";
  };

  network = {
    interface = "wlp3s0";
    format = "";
    format-wifi = " {essid}";
    format-ethernet = "";
    format-disconnected = "";
    max-length = 50;
    on-click = "networkmanager_dmenu &";
    tooltip = false;
  };
}
