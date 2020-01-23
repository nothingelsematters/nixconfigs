{ pkgs, ... }:

let
  theme = import ../../themes { inherit pkgs; };
  zeroX = color: "0x" + builtins.substring 1 6 color;
  monoFont = theme.fonts.mono;
in
{
  home.packages = [ pkgs.alacritty ];

  xdg.configFile.alacritty_config = {
    target = "alacritty/alacritty.yml";
    text =
      ''
      colors:
        primary:
          background: '${zeroX theme.colors.background.primary}'
          foreground: '${zeroX theme.colors.text.primary}'
        cursor:
          text: '${zeroX theme.colors.text.primary}'
          cursor: '${zeroX theme.colors.text.primary}'
          style: Underline
          unfocused_hollow: true
        normal:
          black: '0x3B4252'
          red: '0xBF616A'
          green: '0xA3BE8C'
          yellow: '0xEBCB8B'
          blue: '0x81A1C1'
          magenta: '0xB48EAD'
          cyan: '0x88C0D0'
          white: '0xE5E9F0'
        bright:
          black: '0x4C566A'
          red: '0xBF616A'
          green: '0xA3BE8C'
          yellow: '0xEBCB8B'
          blue: '0x81A1C1'
          magenta: '0xB48EAD'
          cyan: '0x8FBCBB'
          white: '0xECEFF4'

      font:
        normal:
          family: ${monoFont}
        bold:
          family: ${monoFont} Medium
        italic:
          family: ${monoFont} Italic

        size: 6.8
        offset:
          x: 0
          y: 0
        glyph_offset:
          x: 0
          y: 0

        use_thin_strokes: true

      ${builtins.readFile ./alacritty.yml}
      '';
  };
}
