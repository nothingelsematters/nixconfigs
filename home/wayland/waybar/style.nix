{ config, pkgs, lib, ... }:

with config.lib;
functions.toCSS {
  "*" = {
    border = "none";
    border-radius = 0;
    font-family = ''${theme.fonts.notification}, "Font Awesome 5 Brands", ''
      + ''"Font Awesome 5 Free", "Font Awesome 5 Free Solid", ''
      + "Fira code medium, noto-fonts-emoji";
    font-size = "11px";
    min-height = 0;
    margin = "1px 5px 0 5px";
  };

  "window#waybar" = {
    background-color = "transparent";
    color = theme.colors.text.primary;
    transition-property = "background-color";
    transition-duration = ".5s";
    margin = "2px 6px 0 6px";
  };

  "window#waybar.hidden".opacity = 0.2;

  "#custom-apps" = {
    margin-left = "9px";
    margin-right = "1px";
  };

  "#custom-windows" = {
    margin-left = "3px";
    margin-right = 0;
  };

  "#sway-window".margin-left = "3px";

  "#battery".margin-right = 0;
  "#battery.charging".color = theme.colors.text.secondary;
  "#battery.warning:not(.charging)".color = "yellow";
  "#battery.critical:not(.charging)".color = theme.colors.text.urgent;

  "#pulseaudio.muted".color = theme.colors.text.disabled;

  "#tray".margin = "0 0 2px 0";
}
