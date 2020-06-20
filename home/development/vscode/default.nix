args@{ config, pkgs, ... }:

{
  lib.packages.editor = {
    name = "code";
    package = config.programs.vscode.package;
  };

  programs.vscode = {
    enable = true;
    haskell = {
      enable = true;
      hie.enable = false;
    };
    extensions = import ./extensions.nix args;
    userSettings = import ./settings.nix args;
  };
}
