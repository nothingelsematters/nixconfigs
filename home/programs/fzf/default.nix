{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    defaultOptions = [ "-m" "--reverse" ];
    defaultCommand = "rg --files";
  };
}
