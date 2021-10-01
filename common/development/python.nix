{ pkgs, config, ... }:

{
  home.packages = [ (pkgs.python3.withPackages (ps: with ps; [ autopep8 ])) ];

  programs.zsh.shellAliases.py = "python3";
}
