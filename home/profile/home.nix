{ lib, ... }:

{
  imports = import ./import.nix {
    inherit lib;
    dir = ../.;
  };

  lib.packages.editor = "code";

  programs = {
    git.userEmail = "simon.naumov.mail@gmail.com";
    zsh.shellAliases.hms = "nix build '.#home.activationPackage' && ./result/activate";
  };
}
