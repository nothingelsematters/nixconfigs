{ config, pkgs, ... }:

with config.lib;
with theme;
with fonts; {
  lib.packages.terminal = {
    name = "kitty";
    package = pkgs.kitty;
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "${mono.name} 10";
      inherit (mono) package;
    };

    settings = rec {
      font_size = 7;
      cursor_shape = "underline";
      cursor_underline_thickness = "1.1";
      cursor_blink_interval = 0;
      disable_ligatures = "cursor";
      enable_audio_bell = "no";

      foreground = colors.text.primary;
      background = colors.background.primary;
      selection_foreground = colors.text.selection;
      selection_background = colors.background.selection;

      url_color = "#0087BD";
      cursor = color3;
      cursor_text_color = "#282A36";

      # black
      color0 = "#21222c";
      color8 = "#6272a4";

      # red
      color1 = "#e9515c";
      color9 = "#ff6e6e";

      # green
      color2 = "#89ce6b";
      color10 = "#69ff94";

      # yellow
      color3 = "#f7cb69";
      color11 = "#ffffa5";

      # blue
      color4 = "#7bcbeb";
      color12 = "#d6acff";

      # magenta
      color5 = "#8552a8";
      color13 = "#ff92df";

      # cyan
      color6 = "#8be9fd";
      color14 = "#a4ffff";

      # white
      color7 = "#f8f8f2";
      color15 = "#ffffff";
    };
  };
}
