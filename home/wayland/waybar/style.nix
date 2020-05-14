{ config, pkgs, lib, ... }:

with config.lib;
functions.toCss {
  "*" = {
    border = "none";
    border-radius = 0;
    font-family = ''
      ${theme.fonts.notification}, "Font Awesome 5 Brands", "Font Awesome 5 Free", "Font Awesome 5 Free Solid", ''
      + "Fira code medium, noto-fonts-emoji";
    font-size = "12px";
    min-height = 0;
    margin = "0 5px 0 5px";
  };

  "window#waybar" = {
    background-color = "transparent";
    color = theme.colors.text.primary;
    transition-property = "background-color";
    transition-duration = ".5s";
    margin = "2px 6px 0 6px";
  };

  "window#waybar.hidden".opacity = 0.2;

  "#battery.charging".color = theme.colors.text.secondary;
  "#battery.warning:not(.charging)".color = "yellow";
  "#battery.critical:not(.charging)".color = theme.colors.text.urgent;

  "#pulseaudio.muted".color = theme.colors.text.disabled;

  "#custom-apps"."margin-left" = "9px";
  "#network"."margin-right" = "9px";
}
