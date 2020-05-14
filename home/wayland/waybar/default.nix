arg@{ config, pkgs, lib, ... }:

{
  xdg.configFile = {
    "waybar/config".text = import ./config.nix arg;
    "waybar/style.css".text = import ./style.nix arg;
  };
}
