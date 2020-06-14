{ config, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      paging = "never";
      color = "always";
      theme = "Sublime Snazzy";
    };
  };
}
