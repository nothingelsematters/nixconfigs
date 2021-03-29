{ pkgs, ... }:

{
  icons = {
    name = "Papirus";
    package = pkgs.papirus-icon-theme;
  };
  notification-icons = {
    name = "Paper";
    package = pkgs.paper-icon-theme;
  };
}
