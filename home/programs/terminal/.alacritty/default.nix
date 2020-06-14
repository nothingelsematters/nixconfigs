{ config, pkgs, lib, ... }:

with config.lib;
let
  zeroX = color: "0x" + builtins.substring 1 6 color;
  monoFont = theme.fonts.mono.name;
in {
  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";

      window = {
        dimensions = {
          columns = 80;
          lines = 24;
        };

        padding = {
          x = 2;
          y = 2;
        };
        decorations = "full";
      };

      tabspaces = 4;

      draw_bold_text_with_bright_colors = true;

      debug.render_timer = false;

      cursor.style = "Underline";

      visual_bell = {
        animation = "EaseOutExpo";
        duration = 0;
      };

      background_opacity = 1;

      colors = {
        primary = {
          background = zeroX theme.colors.background.primary;
          foreground = zeroX theme.colors.text.primary;
        };

        cursor = {
          text = zeroX theme.colors.text.primary;
          cursor = zeroX theme.colors.text.primary;
          style = "Underline";
          unfocused_hollow = true;

          normal = {
            black = "0x3B4252";
            red = "0xBF616A";
            green = "0xA3BE8C";
            yellow = "0xEBCB8B";
            blue = "0x81A1C1";
            magenta = "0xB48EAD";
            cyan = "0x88C0D0";
            white = "0xE5E9F0";
          };

          bright = {
            black = "0x4C566A";
            red = "0xBF616A";
            green = "0xA3BE8C";
            yellow = "0xEBCB8B";
            blue = "0x81A1C1";
            magenta = "0xB48EAD";
            cyan = "0x8FBCBB";
            white = "0xECEFF4";
          };
        };
      };

      font = {
        normal.family = monoFont;
        bold.family = "${monoFont} Medium";
        italic.family = "${monoFont} Italic";
        size = 7;

        offset = {
          x = 0;
          y = 0;
        };
        glyph_offset = {
          x = 0;
          y = 0;
        };

        use_thin_strokes = true;
      };

      mouse_bindings = [{
        mouse = "Middle";
        action = "PasteSelection";
      }];

      mouse = {
        double_click = { threshold = 300; };
        triple_click = { threshold = 300; };
        faux_scrolling_lines = 1;
        hide_when_typing = false;
      };

      selection.semantic_escape_chars = '',│`|:"' ()[]{}<>'';

      dynamic_title = true;

      live_config_reload = true;

      key_bindings = [
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "Paste";
          action = "Paste";
        }
        {
          key = "Copy";
          action = "Copy";
        }
        {
          key = "Q";
          mods = "Command";
          action = "Quit";
        }
        {
          key = "W";
          mods = "Command";
          action = "Quit";
        }
        {
          key = "Insert";
          mods = "Shift";
          action = "PasteSelection";
        }
        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }
        {
          key = "Equals";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        {
          key = "Subtract";
          mods = "Control";
          action = "DecreaseFontSize";
        }
        {
          key = "Home";
          chars = "\\x1bOH";
          mode = "AppCursor";
        }
        {
          key = "Home";
          chars = "\\x1b[H";
          mode = "~AppCursor";
        }
        {
          key = "End";
          chars = "\\x1bOF";
          mode = "AppCursor";
        }
        {
          key = "End";
          chars = "\\x1b[F";
          mode = "~AppCursor";
        }
        {
          key = "PageUp";
          mods = "Shift";
          chars = "\\x1b[5;2~";
        }
        {
          key = "PageUp";
          mods = "Control";
          chars = "\\x1b[5;5~";
        }
        {
          key = "PageUp";
          chars = "\\x1b[5~";
        }
        {
          key = "PageDown";
          mods = "Shift";
          chars = "\\x1b[6;2~";
        }
        {
          key = "PageDown";
          mods = "Control";
          chars = "\\x1b[6;5~";
        }
        {
          key = "PageDown";
          chars = "\\x1b[6~";
        }
        {
          key = "Tab";
          mods = "Shift";
          chars = "\\x1b[Z";
        }
        {
          key = "Back";
          chars = "\\x7f";
        }
        {
          key = "Back";
          mods = "Alt";
          chars = "\\x1b\\x7f";
        }
        {
          key = "Insert";
          chars = "\\x1b[2~";
        }
        {
          key = "Delete";
          chars = "\\x1b[3~";
        }
        {
          key = "Left";
          mods = "Shift";
          chars = "\\x1b[1;2D";
        }
        {
          key = "Left";
          mods = "Control";
          chars = "\\x1b[1;5D";
        }
        {
          key = "Left";
          mods = "Alt";
          chars = "\\x1b[1;3D";
        }
        {
          key = "Left";
          chars = "\\x1b[D";
          mode = "~AppCursor";
        }
        {
          key = "Left";
          chars = "\\x1bOD";
          mode = "AppCursor";
        }
        {
          key = "Right";
          mods = "Shift";
          chars = "\\x1b[1;2C";
        }
        {
          key = "Right";
          mods = "Control";
          chars = "\\x1b[1;5C";
        }
        {
          key = "Right";
          mods = "Alt";
          chars = "\\x1b[1;3C";
        }
        {
          key = "Right";
          chars = "\\x1b[C";
          mode = "~AppCursor";
        }
        {
          key = "Right";
          chars = "\\x1bOC";
          mode = "AppCursor";
        }
        {
          key = "Up";
          mods = "Shift";
          chars = "\\x1b[1;2A";
        }
        {
          key = "Up";
          mods = "Control";
          chars = "\\x1b[1;5A";
        }
        {
          key = "Up";
          mods = "Alt";
          chars = "\\x1b[1;3A";
        }
        {
          key = "Up";
          chars = "\\x1b[A";
          mode = "~AppCursor";
        }
        {
          key = "Up";
          chars = "\\x1bOA";
          mode = "AppCursor";
        }
        {
          key = "Down";
          mods = "Shift";
          chars = "\\x1b[1;2B";
        }
        {
          key = "Down";
          mods = "Control";
          chars = "\\x1b[1;5B";
        }
        {
          key = "Down";
          mods = "Alt";
          chars = "\\x1b[1;3B";
        }
        {
          key = "Down";
          chars = "\\x1b[B";
          mode = "~AppCursor";
        }
        {
          key = "Down";
          chars = "\\x1bOB";
          mode = "AppCursor";
        }
        {
          key = "F1";
          chars = "\\x1bOP";
        }
        {
          key = "F2";
          chars = "\\x1bOQ";
        }
        {
          key = "F3";
          chars = "\\x1bOR";
        }
        {
          key = "F4";
          chars = "\\x1bOS";
        }
        {
          key = "F5";
          chars = "\\x1b[15~";
        }
        {
          key = "F6";
          chars = "\\x1b[17~";
        }
        {
          key = "F7";
          chars = "\\x1b[18~";
        }
        {
          key = "F8";
          chars = "\\x1b[19~";
        }
        {
          key = "F9";
          chars = "\\x1b[20~";
        }
        {
          key = "F10";
          chars = "\\x1b[21~";
        }
        {
          key = "F11";
          chars = "\\x1b[23~";
        }
        {
          key = "F12";
          chars = "\\x1b[24~";
        }
        {
          key = "F1";
          mods = "Shift";
          chars = "\\x1b[1;2P";
        }
        {
          key = "F2";
          mods = "Shift";
          chars = "\\x1b[1;2Q";
        }
        {
          key = "F3";
          mods = "Shift";
          chars = "\\x1b[1;2R";
        }
        {
          key = "F4";
          mods = "Shift";
          chars = "\\x1b[1;2S";
        }
        {
          key = "F5";
          mods = "Shift";
          chars = "\\x1b[15;2~";
        }
        {
          key = "F6";
          mods = "Shift";
          chars = "\\x1b[17;2~";
        }
        {
          key = "F7";
          mods = "Shift";
          chars = "\\x1b[18;2~";
        }
        {
          key = "F8";
          mods = "Shift";
          chars = "\\x1b[19;2~";
        }
        {
          key = "F9";
          mods = "Shift";
          chars = "\\x1b[20;2~";
        }
        {
          key = "F10";
          mods = "Shift";
          chars = "\\x1b[21;2~";
        }
        {
          key = "F11";
          mods = "Shift";
          chars = "\\x1b[23;2~";
        }
        {
          key = "F12";
          mods = "Shift";
          chars = "\\x1b[24;2~";
        }
        {
          key = "F1";
          mods = "Control";
          chars = "\\x1b[1;5P";
        }
        {
          key = "F2";
          mods = "Control";
          chars = "\\x1b[1;5Q";
        }
        {
          key = "F3";
          mods = "Control";
          chars = "\\x1b[1;5R";
        }
        {
          key = "F4";
          mods = "Control";
          chars = "\\x1b[1;5S";
        }
        {
          key = "F5";
          mods = "Control";
          chars = "\\x1b[15;5~";
        }
        {
          key = "F6";
          mods = "Control";
          chars = "\\x1b[17;5~";
        }
        {
          key = "F7";
          mods = "Control";
          chars = "\\x1b[18;5~";
        }
        {
          key = "F8";
          mods = "Control";
          chars = "\\x1b[19;5~";
        }
        {
          key = "F9";
          mods = "Control";
          chars = "\\x1b[20;5~";
        }
        {
          key = "F10";
          mods = "Control";
          chars = "\\x1b[21;5~";
        }
        {
          key = "F11";
          mods = "Control";
          chars = "\\x1b[23;5~";
        }
        {
          key = "F12";
          mods = "Control";
          chars = "\\x1b[24;5~";
        }
        {
          key = "F1";
          mods = "Alt";
          chars = "\\x1b[1;6P";
        }
        {
          key = "F2";
          mods = "Alt";
          chars = "\\x1b[1;6Q";
        }
        {
          key = "F3";
          mods = "Alt";
          chars = "\\x1b[1;6R";
        }
        {
          key = "F4";
          mods = "Alt";
          chars = "\\x1b[1;6S";
        }
        {
          key = "F5";
          mods = "Alt";
          chars = "\\x1b[15;6~";
        }
        {
          key = "F6";
          mods = "Alt";
          chars = "\\x1b[17;6~";
        }
        {
          key = "F7";
          mods = "Alt";
          chars = "\\x1b[18;6~";
        }
        {
          key = "F8";
          mods = "Alt";
          chars = "\\x1b[19;6~";
        }
        {
          key = "F9";
          mods = "Alt";
          chars = "\\x1b[20;6~";
        }
        {
          key = "F10";
          mods = "Alt";
          chars = "\\x1b[21;6~";
        }
        {
          key = "F11";
          mods = "Alt";
          chars = "\\x1b[23;6~";
        }
        {
          key = "F12";
          mods = "Alt";
          chars = "\\x1b[24;6~";
        }
        {
          key = "F1";
          mods = "Super";
          chars = "\\x1b[1;3P";
        }
        {
          key = "F2";
          mods = "Super";
          chars = "\\x1b[1;3Q";
        }
        {
          key = "F3";
          mods = "Super";
          chars = "\\x1b[1;3R";
        }
        {
          key = "F4";
          mods = "Super";
          chars = "\\x1b[1;3S";
        }
        {
          key = "F5";
          mods = "Super";
          chars = "\\x1b[15;3~";
        }
        {
          key = "F6";
          mods = "Super";
          chars = "\\x1b[17;3~";
        }
        {
          key = "F7";
          mods = "Super";
          chars = "\\x1b[18;3~";
        }
        {
          key = "F8";
          mods = "Super";
          chars = "\\x1b[19;3~";
        }
        {
          key = "F9";
          mods = "Super";
          chars = "\\x1b[20;3~";
        }
        {
          key = "F10";
          mods = "Super";
          chars = "\\x1b[21;3~";
        }
        {
          key = "F11";
          mods = "Super";
          chars = "\\x1b[23;3~";
        }
        {
          key = "F12";
          mods = "Super";
          chars = "\\x1b[24;3~";
        }
      ];
    };
  };
}
