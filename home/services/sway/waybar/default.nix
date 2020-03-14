{ config, pkgs, lib, ... }:

let
  style = import ./style.nix { inherit pkgs lib; };
  configs = import ./config.nix { inherit pkgs lib; };
in {
  xdg.configFile = {
    "waybar/config".text = configs;
    "waybar/style.css".text = style;
  };
}
