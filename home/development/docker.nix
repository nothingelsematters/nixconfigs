{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    d = "docker";
    dc = "docker-compose";

    "dc.up" = "dc up --build --force-recreate";
    "dc.up.d" = "dc up --build --force-recreate --detach";
    "dc.down" = "dc down --remove-orphans --volumes";

    "dc.restart" = "dc.down && dc.up";
  };

  home.packages = with pkgs; [ docker docker-compose dive ];
}
