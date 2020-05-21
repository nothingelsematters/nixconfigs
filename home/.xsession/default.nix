{ config, lib, ... }:

{
  imports = import ../lib/imports.nix lib ./.;
  xsession.enable = true;
  xresources.extraConfig = config.lib.theme.xresources;
}
