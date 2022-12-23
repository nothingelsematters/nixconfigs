{ lib, pkgs, ... }:

{
  imports = import ./import.nix {
    inherit lib;
    dir = ../.;
  };

  programs = {
    git.userEmail = "daretoodefy@gmail.com";

    zsh.shellAliases = {
      hms = "nix build .#mac.activationPackage && ./result/activate";
      "d.launch" = "open /Applications/Docker.app";
    };
  };
}
