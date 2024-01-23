{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    d = "docker";
    dc = "docker-compose";

    "dc.up" = "docker-compose up --build --force-recreate";
    "dc.up.d" = "docker-compose up --build --force-recreate --detach";
    "dc.down" = "docker-compose down --remove-orphans --volumes";

    "dc.restart" = "dc.down && dc.up";
  };

  home.packages = with pkgs; [ docker docker-compose dive ];
}
