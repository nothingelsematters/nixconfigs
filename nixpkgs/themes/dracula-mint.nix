{ pkgs, ... }:

{
  colors = rec {
    background = rec {
      primary        = "#222433";
      secondary      = "#383851";
      disabled       = "#434c5e";
      accent         = "#eceff4";
      strong         = "#88c0d0";
      urgent         = "#bf616a";
      selection      = secondary;
      inverted       = text.primary;
    };
    text = rec {
      primary        = "#b5b9c9";
      secondary      = "#1fa789";
      disabled       = "#4c566a";
      urgent         = "#bf616a";
      inverted       = background.primary;
      selection      = primary;
    };
  };
  xresources = "";
  isDark = true;
}
