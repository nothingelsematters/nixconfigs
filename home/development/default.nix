{ config, pkgs, ... }:

{
  imports = [ ./git ./vscode ./packages.nix ];
}
