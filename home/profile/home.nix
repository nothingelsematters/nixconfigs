{ lib, pkgs, ... }:

{
  imports = import ./import.nix {
    inherit lib;
    dir = ../.;
  };

  home.packages = [ pkgs.heroku ];

  programs = {
    git.userEmail = "daretoodefy@gmail.com";

    zsh.shellAliases = {
      hms = "nix build .#mac.activationPackage && ./result/activate";
      "d.launch" = "open /Applications/Docker.app";
    };
  };
}
