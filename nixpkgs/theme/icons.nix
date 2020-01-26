{ pkgs, ... }:

{
  icons = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
  notification-icons = {
    name = "Paper";
    package = pkgs.paper-icon-theme;
  };
}
