args@{ config, pkgs, ... }:

{
  lib.packages.editor = {
    name = "code";
    package = config.programs.vscode.package;
  };

  programs.vscode = {
    enable = true;
    extensions = import ./extensions.nix args;
    keybindings = import ./keybindings.nix;
    userSettings = import ./settings.nix args;
  };
}
