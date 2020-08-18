arg@{ config, pkgs, lib, ... }:

{
  imports = [ ./config.nix ./style.nix ];

  home.packages = [ pkgs.libappindicator ];
  xsession.preferStatusNotifierItems = true;

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override { pulseSupport = true; };
  };
}
