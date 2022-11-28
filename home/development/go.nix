{ pkgs, ... }:

{
  home.packages = [ pkgs.gopls ];

  programs = {
    go.enable = true;
    vscode.extensions = with pkgs.vscode-extensions; [ golang.go ];
  };
}
