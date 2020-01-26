{ config, pkgs, ... }:

let
  theme = import ../theme { inherit pkgs; };
in
{
  imports = [
    ./i3
    ./mime.nix
  ];
  xsession.enable = true;
  xresources.extraConfig = theme.xresources;
}
