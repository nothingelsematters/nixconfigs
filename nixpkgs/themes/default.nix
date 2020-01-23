args@{ pkgs, ... }:

let
  theme = import ./dracula-mint.nix { inherit args; };
  fonts = import ./fonts.nix { inherit pkgs args; };
in theme // fonts
