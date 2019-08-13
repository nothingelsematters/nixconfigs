{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    defaultCommand = "rg --files";
  };
}
