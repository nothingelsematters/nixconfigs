{ config, pkgs, ... }:

{
  imports = [
    ./i3.nix
  ];
  xsession.enable = true;
}
