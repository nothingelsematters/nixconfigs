{ config, pkgs, ... }:

let
  theme = import ../themes { inherit pkgs; };
in
{
  imports = [
    ./i3
    ./mime.nix
    ./gnome
  ];
  xsession.enable = true;
  xresources.extraConfig = theme.xresources;
}
