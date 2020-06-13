args@{ config, pkgs, lib, ... }:

let
  allHies = fetchTarball "https://github.com/infinisil/all-hies/tarball/master";
  selection = { selector = p: { inherit (p) ghc882; }; };
  hie = (import allHies { }).unstable.selection selection;
in {
  lib.packages.editor = {
    name = "code";
    package = config.programs.vscode.package;
  };

  programs.vscode = {
    enable = true;
    haskell = {
      enable = true;
      hie = {
        enable = true;
        executablePath = hie + /bin/hie;
      };
    };
    extensions = import ./extensions.nix args;
    userSettings = import ./settings.nix args;
  };
}
