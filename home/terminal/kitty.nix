{ config, ... }:

with config.lib.theme; {
  programs.kitty = {
    enable = true;

    font = with fonts; {
      name = mono.name;
      inherit (mono) package;
    };

    settings = with colors;
      with ansi; {
        font_size = 11;
        cursor_shape = "underline";
        cursor_underline_thickness = "1.1";
        cursor_blink_interval = 0;
        disable_ligatures = "cursor";
        enable_audio_bell = "no";
        mouse_hide_wait = "3.0";
        background_opacity = "0.93";

        tab_bar_edge = "top";
        tab_bar_style = "slant";

        url_color = "#0087BD";
        cursor = "#e0e4e8";
        background = background.primary;
        cursor_text_color = text.primary;
        selection_foreground = text.selection;
        selection_background = background.selection;

        color0 = black;
        color1 = red;
        color2 = green;
        color3 = yellow;
        color4 = blue;
        color5 = magenta;
        color6 = cyan;
        color7 = white;
        color8 = blackBright;
        color9 = redBright;
        color10 = greenBright;
        color11 = yellowBright;
        color12 = blueBright;
        color13 = magentaBright;
        color14 = cyanBright;
        color15 = whiteBright;
      };
  };
}
