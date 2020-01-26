{ pkgs, ... }:

let
  theme = import ../../theme { inherit pkgs; };
  cfg = builtins.replaceStrings
    [ "editor:" ]
    [ "editor:\n    fontFamily: \"${theme.fonts.mono}\"" ]
    (builtins.readFile ./config.cson);
in
with builtins; {
  home.file.".atom/config.cson".text = cfg;
  home.file.".atom/snippets.cson".source = ./snippets.cson;

  home.file.".atom/packages/material-monokai-syntax/styles/syntax-variables.less".text = ''
  @import "colors";
  // This defines all syntax variables that syntax themes must implement when they
  // include a syntax-variables.less file.

  @syntax-cursor-line: hsla(220, 100%,  80%, .04); // needs to be semi-transparent to show serach results
  @syntax-bracket-matcher-background-color: lighten(@syntax-background-color, 8%);

  // General colors
  @syntax-text-color: #CDD3DE;
  @syntax-cursor-color: #c0c5ce;
  @syntax-selection-color: rgba(128, 203, 196, 0.13);
  @syntax-background-color: ${theme.colors.background.primary};
  @syntax-comments-color: #506E79;

  // Guide colors
  @syntax-wrap-guide-color: #65737e;
  @syntax-indent-guide-color: #65737e;
  @syntax-invisible-character-color: #65737e;

  // For find and replace markers
  @syntax-result-marker-color: #65737e;
  @syntax-result-marker-color-selected: #CDD3DE;

  // Gutter colors
  @syntax-gutter-text-color: @syntax-comments-color;
  @syntax-gutter-text-color-selected: #CDD3DE;
  @syntax-gutter-background-color: ${theme.colors.background.primary};
  @syntax-gutter-background-color-selected: rgba(0, 0, 0, 0.19);

  // For git diff info. i.e. in the gutter
  // These are static and were not extracted from your textmate theme
  @syntax-color-renamed: #64B5F6;
  @syntax-color-added: @green;
  @syntax-color-modified: @yellow;
  @syntax-color-removed: @red;
  '';


  home.file.".atom/packages/atom-material-ui/styles/user-settings.less".text = ''
  @accent-color: ${theme.colors.background.primary};
  @accent-text-color: ${theme.colors.text.selection};
  @base-color: ${theme.colors.background.primary};
  '';
}
