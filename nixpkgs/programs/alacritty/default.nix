{ pkgs, ... }:

{
  home.packages = [
    pkgs.alacritty
  ];
  xdg.configFile.alacritty_config = {
    source = ./alacritty.yml;
    target = "alacritty/alacritty.yml";
  };
}
