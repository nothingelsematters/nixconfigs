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
        confirm_os_window_close = 2;

        font_size = 11;
        cursor_shape = "underline";
        cursor_underline_thickness = "1.1";
        cursor_blink_interval = 0;
        disable_ligatures = "cursor";
        enable_audio_bell = "no";
        mouse_hide_wait = "3.0";
        background_opacity = "0.93";

        tab_bar_edge = "top";
        tab_fade = "0.33 0.67 1";
        tab_bar_min_tabs = 1;
        tab_title_template = "{fmt.fg.tab}{fmt.noitalic}{sup.index}{title}";

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

    extraConfig = ''
      map ctrl+1 goto_tab 1
      map cmd+1  goto_tab 1
      map ctrl+2 goto_tab 2
      map cmd+2  goto_tab 2
      map ctrl+3 goto_tab 3
      map cmd+3  goto_tab 3
      map ctrl+4 goto_tab 4
      map cmd+4  goto_tab 4
      map ctrl+5 goto_tab 5
      map cmd+5  goto_tab 5
      map ctrl+6 goto_tab 6
      map cmd+6  goto_tab 6
      map ctrl+7 goto_tab 7
      map cmd+7  goto_tab 7
      map ctrl+8 goto_tab 8
      map cmd+8  goto_tab 8
      map ctrl+9 goto_tab 9
      map cmd+9  goto_tab 9
    '';
  };
}
