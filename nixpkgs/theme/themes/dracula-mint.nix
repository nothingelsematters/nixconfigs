{ ... }:

{
  colors = rec {
    background = rec {
      primary        = "#222433";
      secondary      = "#383851";
      disabled       = "#2d2e42";
      accent         = "#eceff4";
      strong         = "#88c0d0";
      urgent         = "#bf616a";
      selection      = secondary;
      inverted       = text.primary;
    };
    text = rec {
      primary        = "#c5ccd2";
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
