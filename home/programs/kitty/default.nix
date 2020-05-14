{ config, pkgs, lib, ... }:

with config.lib;
let mono = theme.fonts.mono;
in rec {
  lib.terminal = {
    name = "kitty";
    package = pkgs.kitty;
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "${mono.name} 10";
      inherit (mono) package;
    };

    settings = {
      font_size = 7;
      cursor_shape = "underline";
      cursor_blink_interval = 0;
      disable_ligatures = "cursor";
      enable_audio_bell = "no";

      foreground = theme.colors.text.primary;
      background = theme.colors.background.primary;
      selection_foreground = theme.colors.text.selection;
      selection_background = theme.colors.background.selection;

      url_color = "#0087BD";
      cursor = "#97979B";
      cursor_text_color = "#282A36";

      # black
      color0 = "#21222c";
      color8 = "#6272a4";

      # red
      color1 = "#ff5555";
      color9 = "#ff6e6e";

      # green
      color2 = "#50fa7b";
      color10 = "#69ff94";

      # yellow
      color3 = "#f1fa8c";
      color11 = "#ffffa5";

      # blue
      color4 = "#bd93f9";
      color12 = "#d6acff";

      # magenta
      color5 = "#ff79c6";
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
