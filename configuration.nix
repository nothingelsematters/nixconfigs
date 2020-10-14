{ pkgs, lib, ... }:

let sources = import ./nix/sources.nix;
in {
  imports = [ ./hosts/simyon "${sources.home-manager}/nixos" ./cachix ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = import ./nix lib;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
  };
}
