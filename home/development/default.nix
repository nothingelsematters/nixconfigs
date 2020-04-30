{ config, pkgs, ... }:

{
  imports = [ ./atom ./git ./packages.nix ];
}
