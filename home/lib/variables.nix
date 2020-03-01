{ pkgs, ... }:

{
  terminal = {
    name = "kitty";
    package = pkgs.kitty;
  };

  bar-height = 22;
}
