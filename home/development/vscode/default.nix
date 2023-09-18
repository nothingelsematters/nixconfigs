args@{ config, pkgs, ... }:

{
  lib.packages.editor = "code";

  programs.vscode = {
    enable = true;
    extensions = import ./extensions.nix args;
    keybindings = import ./keybindings.nix;
    userSettings = import ./settings.nix args;
  };
}
