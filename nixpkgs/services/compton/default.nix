{ pkgs, ... }:

{
  services.compton = {
    enable = true;

    inactiveOpacity = "0.87";
    opacityRule = [ "95:class_i ?= 'Alacritty'" ];

    blur = true;

    fade = true;
    fadeDelta = 3;
    fadeSteps = [ "0.01"  "0.015" ];
  };
}
