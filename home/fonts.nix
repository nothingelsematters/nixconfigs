{ lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  lib.fonts.mono = {
    name = "Jetbrains Mono";
    package = pkgs.jetbrains-mono;
  };
}
