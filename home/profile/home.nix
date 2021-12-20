{ config, lib, pkgs, ... }:

{
  imports = [ ./common.nix ];

  programs = {
    zsh.shellAliases.hms =
      "nix build .#mac.activationPackage && ./result/activate";

    git = {
      userName = "Simon Naumov";
      userEmail = "daretoodefy@gmail.com";
    };
  };
}
