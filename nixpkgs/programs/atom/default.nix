{ pkgs, ... }:

let
  theme = import ../../themes { inherit pkgs; };
in
with builtins; {
  home.file.".atom/config.cson".text = readFile ./config.cson;
  home.file.".atom/snippets.cson".text = readFile ./snippets.cson;
  home.file.".atom/packages/material-monokai-syntax/styles/syntax-variables.less".text = readFile ./syntax-theme.less;
  home.file.".atom/packages/atom-material-ui/styles/user-settings.less".text =
  ''
  @accent-color: ${theme.colors.background.primary};
  @accent-text-color: ${theme.colors.text.selection};
  @base-color: ${theme.colors.background.primary};
  '';
}
