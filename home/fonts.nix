{ lib, pkgs, ... }:

rec {
  fonts.fontconfig.enable = true;

  home.packages = [
    lib.fonts.mono.package
  ];

  lib.fonts.mono = {
    name = "JetBrainsMono Nerd Font Mono";
    package = pkgs.nerd-fonts.jetbrains-mono;
  };
}
