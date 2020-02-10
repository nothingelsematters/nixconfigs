{ pkgs, ... }:

{
  services.compton = {
    enable = true;

    inactiveDim = "0.1";
    inactiveOpacity = "0.87";
    menuOpacity = "0.8";

    blur = true;

    shadow = true;
    shadowExclude = [ "window_type *= 'menu'" "name ~= 'Telegram'" "name ~= 'Firefox'" ];
    shadowOpacity = "0.9";
    shadowOffsets = [ (-20) (-20) ];

    fade = true;
    fadeDelta = 5;
    fadeSteps = [ "0.034" "0.018" ];
  };
}
