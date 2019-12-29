{ pkgs, ... }:

{
  services.compton = {
    enable = true;

    inactiveOpacity = "0.87";
    menuOpacity = "0.92";

    blur = true;

    fade = true;
    fadeDelta = 3;
    fadeSteps = [ "0.01"  "0.015" ];
  };
}
