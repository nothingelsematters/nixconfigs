{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ imagemagick i3lock-fancy maim ];

  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd =
      "\${pkgs.i3lock-fancy}/bin/i3lock-fancy -f Comfortaa-Light \${pkgs.maim}/bin/maim";
  };
}
