args@{ pkgs, ... }:

let
  theme = import ./themes/dracula-mint.nix { inherit args; };
  fonts = import ./fonts.nix { inherit pkgs args; };
  icons = import ./icons.nix { inherit pkgs args; };
  gtk = import ./gtk.nix { inherit pkgs args; };
in theme // fonts // icons // gtk
