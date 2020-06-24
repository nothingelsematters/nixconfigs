args@{ config, pkgs, ... }:

{
  lib.packages.editor = {
    name = "code";
    package = config.programs.vscode.package;
  };

  xdg.configFile."Code/User/keybindings.json".text =
    builtins.toJSON (import ./keybindings.nix);

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
