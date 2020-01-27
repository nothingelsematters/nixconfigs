{ pkgs, ... }:

{
  gtk = {
    name = "Materia";
    package = pkgs.materia-theme;
  };
  cursor = {
    size = 15;
    name = "Paper";
    package = pkgs.paper-icon-theme;
  };
}
