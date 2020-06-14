{ config, pkgs, ... }:

{
  home.packages = [ pkgs.pass ];
  programs.browserpass = {
    enable = true;
    browsers = [ config.lib.packages.browser.name ];
  };
}
