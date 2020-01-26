{ pkgs, ... }:

{
  gtk = {
    name = "Materia";
    package = pkgs.materia-theme;
  };
  cursor = {
    name = "Paper";
    package = pkgs.paper-icon-theme;
  };
}
