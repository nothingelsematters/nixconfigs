_:

{
  colors = rec {
    background = rec {
      primary = "#1f2428";
      secondary = "#2f363d";
      disabled = "#2f363d";
      accent = "#717790";
      urgent = "#f44d4d";
      selection = secondary;
      inverted = text.primary;
    };
    text = rec {
      primary = "#e2e2e4";
      secondary = "#044289";
      disabled = "#5b5d67";
      urgent = background.urgent;
      inverted = background.primary;
      selection = primary;
    };
  };
  xresources = "";
  isDark = true;
}
