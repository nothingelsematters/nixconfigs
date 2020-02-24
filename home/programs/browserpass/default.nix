{ config, pkgs, ... }:

{
  home.packages = [ pkgs.pass ];
  programs.browserpass = {
    enable = config.programs.firefox.enable;
    browsers = [ "firefox" ];
  };
}
