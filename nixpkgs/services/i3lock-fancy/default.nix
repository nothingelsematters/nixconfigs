{ config, pkgs, ... }:

{
  home.packages = [ pkgs.imagemagick pkgs.i3lock-fancy ];

  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy -f Comfortaa-Light ${pkgs.maim}/bin/maim";
  };
}
