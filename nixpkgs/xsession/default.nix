{ config, pkgs, ... }:

{
  imports = [
    ./i3
    ./mime.nix
    ./gnome
  ];
  xsession.enable = true;
}
