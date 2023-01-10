args@{ config, pkgs, ... }:

{
  lib.packages.editor = {
    command = "code";
    package = config.programs.vscode.package;
  };

  programs.vscode = {
    enable = true;
    extensions = import ./extensions.nix args;
    keybindings = import ./keybindings.nix;
    userSettings = import ./settings.nix;
  };
}
