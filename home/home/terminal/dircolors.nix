{ inputs, ... }:

{
  programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile (inputs.nord-dircolors + /src/dir_colors);
  };
}
