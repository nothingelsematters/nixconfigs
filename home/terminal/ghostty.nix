{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    enableZshIntegration = true;

    settings = {
      # font
      font-family = config.lib.fonts.mono.name;
      font-size = 12;

      # cursor & mouse
      cursor-style-blink = false;
      cursor-color = "#e0e4e8";
      cursor-text = "#e0e3e8";
      mouse-hide-while-typing = true;
      quit-after-last-window-closed = true;

      # window and background
      background-blur = "macos-glass-clear";
      background-opacity = 0.85;
      window-padding-x = 10;
      window-padding-y = 10;
      macos-titlebar-style = "tabs";

      # colors
      selection-background = "#1d476a";
      selection-foreground = "#e0e3e8";
      palette = [
        "0=#586069"
        "1=#ea4a5a"
        "2=#34d058"
        "3=#ffea7f"
        "4=#2188ff"
        "5=#b392f0"
        "6=#39c5cf"
        "7=#d1d5da"
        "8=#959da5"
        "9=#f97583"
        "10=#85e89d"
        "11=#ffea7f"
        "12=#79b8ff"
        "13=#b392f0"
        "14=#56d4dd"
        "15=#fafbfc"
      ];
    };
  };
}
