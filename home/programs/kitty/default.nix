{ config, pkgs, lib, ... }:

let
  theme = import ../../theme { inherit pkgs lib; };
  mono = theme.fonts.mono;
in rec {
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
      color0 = "#282a36";
      color8 = "#686868";

      # red
      color1 = "#FF5C57";
      color9 = "#FF5C57";

      # green
      color2 = "#5AF78E";
      color10 = "#5AF78E";

      # yellow
      color3 = "#F3F99D";
      color11 = "#F3F99D";

      # blue
      color4 = "#57C7FF";
      color12 = "#57C7FF";

      # magenta
      color5 = "#FF6AC1";
      color13 = "#FF6AC1";

      # cyan
      color6 = "#9AEDFE";
      color14 = "#9AEDFE";

      # white
      color7 = "#F1F1F0";
      color15 = "#EFF0EB";
    };
  };
}
