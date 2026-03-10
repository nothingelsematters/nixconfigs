{ pkgs, ... }:

{
  home.packages = [ pkgs.gopls ];

  programs = {
    go.enable = true;
    vscode.profiles.default.extensions = with pkgs.vscode-extensions; [ golang.go ];
  };
}
