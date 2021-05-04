{ config, pkgs, ... }:

{
  programs.zsh.shellAliases.dc = "docker-compose";

  home.packages = with pkgs; [
    # nix
    nixfmt
    cachix
    manix
    cached-nix-shell

    # docker
    docker
    docker_compose
  ];
}
