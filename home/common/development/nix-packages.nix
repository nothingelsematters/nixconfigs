{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ nixfmt cachix manix cached-nix-shell ];
}
