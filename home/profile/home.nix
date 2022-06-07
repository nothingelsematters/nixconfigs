{ lib, pkgs, ... }:

{
  imports = import ./import.nix {
    inherit lib;
    dir = ../.;
    recursive = true;
    includeFiles = true;
    exclude = [ "profile" ];
  };

  home.packages = [ pkgs.heroku ];

  programs = {
    zsh.shellAliases = {
      hms = "nix build .#mac.activationPackage && ./result/activate";
      dlaunch = "open /Applications/Docker.app";
    };

    git = {
      userName = "Simon Naumov";
      userEmail = "daretoodefy@gmail.com";
    };
  };
}
