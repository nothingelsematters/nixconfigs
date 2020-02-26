{ config, pkgs, ... }:

{
  imports = [ ./hosts/simyon ];

  nixpkgs.config.allowUnfree = true;

  i18n.defaultLocale = "en_US.UTF-8";

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
  };
}
