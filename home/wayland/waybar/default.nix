arg@{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.libappindicator ];
  xsession.preferStatusNotifierItems = true;

  xdg.configFile = {
    "waybar/config".text = import ./config.nix arg;
    "waybar/style.css".text = import ./style.nix arg;
  };
}
