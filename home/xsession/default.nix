{ config, pkgs, lib, ... }:

let theme = import ../theme { inherit pkgs lib; };
in {
  imports = [ ./i3 ./mime.nix ];
  xsession.enable = true;
  xresources.extraConfig = theme.xresources;
}
