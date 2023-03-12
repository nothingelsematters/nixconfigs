{ pkgs, ... }:

{
  home.packages = [ pkgs.subversion ];

  programs.vscode.userSettings."[latex]" = {
    "editor.wordWrap" = "bounded";
    "editor.wordWrapColumn" = 1000;
  };
}
