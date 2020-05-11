{ config, pkgs, lib, ... }:

{
  xdg.configFile = {
    "waybar/config".text = import ./config.nix { inherit pkgs lib; };
    "waybar/style.css".text = import ./style.nix { inherit pkgs lib; };
  };
}
