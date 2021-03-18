{ config, lib, pkgs, ... }:

{
  imports = [
    ./development/git/common.nix

    ./terminal/bat.nix
    ./terminal/fzf.nix
    ./terminal/htop.nix
    ./terminal/packages.nix
    ./terminal/starship.nix
    ./terminal/z-lua.nix
    ./terminal/zsh.nix
  ];

  home.packages = with pkgs; [ jdk11 maven ];

  programs.zsh.shellAliases.hms = "home-manager switch";

  programs.starship.settings = {
    git_branch.symbol = "on ";
    java.symbol = "java ";
    character = {
      success_symbol = "[>](bold green)";
      error_symbol = "[>](bold red)";
      vicmd_symbol = "[<](bold green)";
    };
  };

  nixpkgs.overlays = with lib;
    trivial.pipe ../nix/sources.nix [
      import
      (filterAttrs (name: _: name != "__functor"))
      (mapAttrsToList (name: value: _: _: { "${name}" = value; }))
    ];

  lib.theme.isDark = true;

  programs.home-manager = {
    enable = true;
    path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
  };
}
