args@{ pkgs, lib, ... }:

let
  theme = import ./colors/dracula-mint.nix args;
  fonts = import ./fonts.nix args;
  icons = import ./icons.nix args;
  gtk = import ./gtk.nix args;
in {
  imports = [ ./utils ];
  lib.theme = theme // fonts // icons // gtk;
}
