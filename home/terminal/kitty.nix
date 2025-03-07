{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = config.lib.fonts.mono;
    shellIntegration.mode = "no-cursor no-title";

    settings = {
      confirm_os_window_close = 2;

      font_size = 12;
      cursor_shape = "underline";
      cursor_underline_thickness = "1";
      cursor_blink_interval = 0;
      disable_ligatures = "cursor";
      enable_audio_bell = "no";
      mouse_hide_wait = "3.0";
      background_opacity = "0.93";

      tab_bar_edge = "top";
      tab_fade = "1";
      tab_bar_min_tabs = 1;
      tab_title_template = "{fmt.fg.tab}{fmt.noitalic}{sup.index}{title}";
      tab_title_max_length = 50;

      url_color = "#0087BD";
      cursor = "#e0e4e8";
      background = "#23282e";
      selection_background = "#1d476a";
      cursor_text_color = "#e0e3e8";
      selection_foreground = "#e0e3e8";

      color0 = "#586069";
      color1 = "#ea4a5a";
      color2 = "#34d058";
      color3 = "#ffea7f";
      color4 = "#2188ff";
      color5 = "#b392f0";
      color6 = "#39c5cf";
      color7 = "#d1d5da";
      color8 = "#959da5";
      color9 = "#f97583";
      color10 = "#85e89d";
      color11 = "#ffea7f";
      color12 = "#79b8ff";
      color13 = "#b392f0";
      color14 = "#56d4dd";
      color15 = "#fafbfc";
    };

    extraConfig = ''
      map cmd+1  goto_tab 1
      map cmd+2  goto_tab 2
      map cmd+3  goto_tab 3
      map cmd+4  goto_tab 4
      map cmd+5  goto_tab 5
      map cmd+6  goto_tab 6
      map cmd+7  goto_tab 7
      map cmd+8  goto_tab 8
      map cmd+9  goto_tab 9
    '';
  };
}
