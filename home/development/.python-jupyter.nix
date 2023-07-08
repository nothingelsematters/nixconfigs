{ pkgs, ... }:

{
  home.packages =
    [ (pkgs.python311.withPackages (ps: with ps; [ autopep8 jupyter scipy ])) ];

  programs.vscode.extensions = [ pkgs.vscode-extensions.ms-toolsai.jupyter ];
}
