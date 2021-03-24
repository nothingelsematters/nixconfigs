{ config, lib, pkgs, ... }:

{
  imports = [
    ./development/git/common.nix

    ./terminal/bat.nix
    ./terminal/fzf.nix
    ./terminal/htop.nix
    ./terminal/packages.nix
    ./terminal/z-lua.nix
    ./terminal/zsh.nix
  ];

  home.packages = with pkgs; [ jdk11 maven cached-nix-shell ];

  nixpkgs.overlays = with lib;
    trivial.pipe ../nix/sources.nix [
      import
      (filterAttrs (name: _: name != "__functor"))
      (mapAttrsToList (name: value: _: _: { "${name}" = value; }))
    ];

  lib.theme.isDark = true;

  programs = {
    zsh.shellAliases.hms = "home-manager switch";

    starship = (import ./terminal/starship.nix).programs.starship // {
      settings = {
        git_branch.symbol = "";
        java.symbol = "java ";
        nix_shell.symbol = "nix ";
        jobs.symbol = "+";

        custom = { };

        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[>](bold red)";
          vicmd_symbol = "[<](bold green)";
        };
        format = "$shlvl" + "$directory" + "$git_branch" + "$git_commit"
          + "$git_state" + "$docker_context" + "$package" + "$java"
          + "$nix_shell" + "$memory_usage" + "$cmd_duration" + "$line_break"
          + "$jobs" + "$battery" + "$character";
      };
    };

    home-manager = {
      enable = true;
      path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
    };
  };
}
