args@{ lib, pkgs, ... }:

{
  home.packages = [ pkgs.jetbrains-mono ];

  lib.theme = {
    isDark = true;

    colors = rec {
      background = rec {
        primary = "#23282e";
        secondary = "#1d476a";
        disabled = "#2a3037";
        urgent = "#ea4a5a";
        selection = secondary;
        inverted = text.primary;
      };

      text = rec {
        primary = "#e0e3e8";
        secondary = "#68737e";
        disabled = "#68737e";
        urgent = background.urgent;
        selection = primary;
        inverted = background.primary;
      };

      ansi = {
        black = "#586069";
        red = "#ea4a5a";
        green = "#34d058";
        yellow = "#ffea7f";
        blue = "#2188ff";
        magenta = "#b392f0";
        cyan = "#39c5cf";
        white = "#d1d5da";
        blackBright = "#959da5";
        redBright = "#f97583";
        greenBright = "#85e89d";
        yellowBright = "#ffea7f";
        blueBright = "#79b8ff";
        magentaBright = "#b392f0";
        cyanBright = "#56d4dd";
        whiteBright = "#fafbfc";
      };
    };

    fonts.mono = {
      name = "Jetbrains Mono";
      package = pkgs.jetbrains-mono;
    };
  };
}
