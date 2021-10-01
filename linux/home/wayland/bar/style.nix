{ config, lib, ... }:

with config.lib;
with builtins;
with lib.attrsets;
let
  margin = toString (config.wayland.windowManager.sway.config.gaps.outer + 2);

  toCSS = let
    concatMapped = f: set: concatStringsSep "\n" (mapAttrsToList f set);
    mapValues = name: value: "    ${name}: ${toString value};";
    mapGroups = name: value: ''
      ${name} {
      ${concatMapped mapValues value}
      }'';
  in concatMapped mapGroups;
in {
  programs.waybar.style = toCSS {
    "*" = {
      font-family = ''${theme.fonts.notification}, "Font Awesome 5 Brands", ''
        + ''"Font Awesome 5 Free", "Font Awesome 5 Free Solid", ''
        + "Fira code medium, noto-fonts-emoji";
      font-size = "11px";
      margin = "0 ${margin}px 0 ${margin}px";
    };

    "window#waybar" = {
      background-color = "transparent";
      color = theme.colors.text.primary;
    };

    "#custom-windows".margin = "0 0 0 0";

    "#custom-spotify".margin-top = "4px";

    "#pulseaudio.muted".color = theme.colors.text.disabled;

    "#battery.charging".color = theme.colors.text.secondary;
    "#battery.warning:not(.charging)".color = "yellow";
    "#battery.critical:not(.charging)".color = theme.colors.text.urgent;

    "#tray".margin = "0 0 3px 0";
  };
}
