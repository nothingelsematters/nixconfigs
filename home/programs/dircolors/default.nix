{ config, pkgs, ... }:

{
  programs.dircolors = {
    enable = true;
    extraConfig =
      builtins.readFile (config.lib.sources.nord-dircolors + /src/dir_colors);
  };
}
