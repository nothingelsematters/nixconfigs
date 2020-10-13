_:

{
  colors = rec {
    background = rec {
      primary = "#292d3e";
      secondary = "#353a51";
      disabled = "#353a51";
      accent = "#717790";
      urgent = "#f44d4d";
      selection = secondary;
      inverted = text.primary;
    };
    text = rec {
      primary = "#e2e2e4";
      secondary = "#25a487";
      disabled = "#5b5d67";
      urgent = background.urgent;
      inverted = background.primary;
      selection = primary;
    };
  };
  xresources = "";
  isDark = true;
}
