{ lib, pkgs, ... }:

{
  imports = [
    ./packages
    ./xsession/gnome
    ./services/unclutter.nix
    ./services/nm-applet.nix
    ./services/udiskie.nix
    ./services/guake
    /* ./programs/browserpass.nix
    ./programs/most.nix
    ./programs/zsh.nix */
  ];

  home = {
    sessionVariables = {
      FZF_DEFAULT_COMMAND="rg --files";
      EDITOR="atom";
      PAGER="most";
    };
    keyboard = {
      layout = "us,ru";
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  programs = {
    home-manager.enable = true;
    home-manager.path = https://github.com/rycee/home-manager/archive/master.tar.gz;
  };
}
