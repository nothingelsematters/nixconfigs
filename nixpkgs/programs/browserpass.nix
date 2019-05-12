{ pkgs, ... }:

{
  home.packages = [
    pkgs.pass
  ];
  programs.browserpass = {
    enable = true;
    browsers = [ "firefox" ];
  };
}
