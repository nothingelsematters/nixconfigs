{ lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  lib.fonts.mono = {
    name = "JetBrainsMono Nerd Font Mono";
    package = pkgs.nerd-fonts.jetbrains-mono;
  };
}
