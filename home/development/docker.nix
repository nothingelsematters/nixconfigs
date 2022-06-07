{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    dc = "docker-compose";
    dc-restart =
      "dc down --remove-orphans --volumes && dc up --detach --build --force-recreate";
    dlaunch = "open /Applications/Docker.app";
  };

  home.packages = with pkgs; [ docker pkgs.stable.docker-compose dive ];
}
