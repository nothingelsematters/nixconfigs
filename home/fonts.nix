{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerdfonts
    jetbrains-mono
  ];

  lib.fonts.mono = {
    name = "Jetbrains Mono";
    package = pkgs.jetbrains-mono;
  };
}
