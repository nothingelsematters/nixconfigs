{ config, pkgs, ...}:

let
  theme = import ../../themes { inherit pkgs; };
in

{
  programs.rofi = {
    enable = true;
    lines = 7;
    font = "Hasklig Semibold 9.6";
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
        background = "${theme.colors.background.secondary}";
        border = "${theme.colors.background.inverted}";
        separator = "${theme.colors.background.inverted}";
      };

      rows = {
        normal = {
          background = "${theme.colors.background.secondary}";
          foreground = "${theme.colors.text.primary}";
          backgroundAlt = "${theme.colors.background.secondary}";

          highlight = {
            background = "${theme.colors.background.inverted}";
            foreground = "${theme.colors.text.inverted}";
          };
        };
      };
    };
  };
}
