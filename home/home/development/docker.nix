{ config, pkgs, ... }:

{
  programs.zsh.shellAliases.dc = "docker-compose";

  home.packages = with pkgs; [ docker docker_compose ];
}
