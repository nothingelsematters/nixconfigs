{ pkgs, ... }:

{
  home.packages =
    [ (pkgs.python310.withPackages (ps: with ps; [ autopep8 jupyter scipy ])) ];

  programs = {
    zsh.shellAliases = {
      py = "python3";
      ipy = "ipython";
    };
    vscode.extensions = [ pkgs.vscode-extensions.ms-toolsai.jupyter ];
  };
}
