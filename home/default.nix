{ config, lib, pkgs, ... }:

{
  imports = import ../lib/imports.nix {
    inherit lib;
    dir = ./.;
    recursive = true;
    includeFiles = true;
  };

  programs.zsh.shellAliases.hms =
    "nix build .#mac.activationPackage && ./result/activate";
}
