{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    defaultOptions = [ "-m" ];
    defaultCommand = "rg --files";
  };
}
