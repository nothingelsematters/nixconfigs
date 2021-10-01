{ pkgs, ... }:

{
  home.packages = with pkgs;
    [ (texlive.combine { inherit (texlive) scheme-full latexmk; }) ];

  programs.vscode = {
    userSettings."[latex]"."editor.wordWrap" = "on";
    extensions = [ pkgs.vscode-extensions.james-yu.latex-workshop ];
  };
}
