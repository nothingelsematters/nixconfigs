{ config, pkgs, ... }:

{
  programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile (pkgs.nord-dircolors + /src/dir_colors);
  };
}
