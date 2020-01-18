{ pkgs, ... }:

{
  services.compton = {
    enable = true;

    inactiveOpacity = "0.87";
    menuOpacity = "0.92";

    blur = true;

    fade = true;
    fadeDelta = 5;
    fadeSteps = [ "0.034" "0.018" ];
  };
}
