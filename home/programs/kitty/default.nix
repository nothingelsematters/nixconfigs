{ config, pkgs, lib, ... }:

let
  theme = import ../../theme { inherit pkgs lib; };
  mono = theme.fonts.mono;
in {
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

      foreground = theme.colors.text.primary;
      background = theme.colors.background.primary;
      selection_foreground = theme.colors.text.selection;
      selection_background = theme.colors.background.selection;
    };
  };
}
