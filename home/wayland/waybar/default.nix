arg@{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.libappindicator ];

  xsession.preferStatusNotifierItems = true;

  # BUG tray windows are under main ones
  xdg.configFile = {
    "waybar/config".text = import ./config.nix arg;
    "waybar/style.css".text = import ./style.nix arg;
  };
}
