{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gopls
    richgo
  ];

  programs = {
    go.enable = true;
    vscode.profiles.default.extensions = with pkgs.vscode-extensions; [ golang.go ];
  };
}
