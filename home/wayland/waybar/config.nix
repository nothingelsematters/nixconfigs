arg@{ config, pkgs, lib, ... }:

with config.lib;
let
  windows = import ./windows arg;
  layout = import ./layout arg;
in builtins.toJSON {
  height = constants.barHeight;

  layer = "bottom";
  position = "top";

  modules-left = [ "custom/apps" "custom/windows" "sway/window" ];
  modules-center = [ "clock" ];
  modules-right = [ "custom/layout" "pulseaudio" "battery" "cpu" "network" ];

  "custom/apps" = {
    format = "";
    on-click = "${packages.launcher.cmd}";
    tooltip = false;
  };

  "custom/windows" = windows;

  "sway/window" = {
    format = "{}";
    max-length = 50;
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
    format = "{icon} {capacity}%";
    interval = 5;
    states = {
      warning = 20;
      critical = 10;
    };
    format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
  };

  cpu = {
    interval = 3;
    format = " {usage}%";
    max-length = 10;
    tooltip = false;
    on-click = "kitty htop &";
  };

  network = {
    interface = "wlp3s0";
    format = "{ifname}";
    format-wifi = " {essid} ({signalStrength}%)";
    format-ethernet = "{ifname} ";
    format-disconnected = "";
    max-length = 50;
    on-click = "networkmanager_dmenu &";
    tooltip = false;
  };
}
