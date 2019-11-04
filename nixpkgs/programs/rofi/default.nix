# TODO theme
{ config, pkgs, ...}:

let
  theme = import ../../themes;
in

{
  programs.rofi = {
    enable = true;
    lines = 7;
    font = "Fira Code 16";
    extraConfig =
      ''
      rofi.modi:                drun
      rofi.matching:            fuzzy
      rofi.drun-match-fields:   name
      rofi.drun-display-format: {name}
      rofi.kb-row-select:       ctrl+shift+space
      rofi.kb-cancel:           Menu,Escape,alt+r
      rofi.show-icons:          true
      rofi.kb-row-tab:          shift+Tab
      '';
    colors = {
      window = {
        background = "${theme.colors.accent}";
        border = "${theme.colors.text}";
        separator = "${theme.colors.text}";
      };

      rows = {
        normal = {
          background = "${theme.colors.accent}";
          foreground = "${theme.colors.text}";
          backgroundAlt = "${theme.colors.accent}";
          highlight = {
            background = "${theme.colors.active}";
            foreground = "${theme.colors.primary}";
          };
        };
      };
    };
  };
}
