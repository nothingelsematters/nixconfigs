{ lib, config, ... }:

with config.lib; {
  imports = [ ../../lib ] ++ import ../../lib/imports.nix {
    inherit lib;
    dir = ./.;
    recursive = true;
    includeFiles = true;
  };

  nixpkgs = {
    overlays = import ../../nix lib;

    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.strings.getName pkg) [
        "typora"
        "slack"
        "vscode"
        "spotify"
        "spotify-unwrapped"
      ];
  };

  manual.manpages.enable = true;

  programs.home-manager = {
    enable = true;
    path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
  };
}
