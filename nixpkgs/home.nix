{ lib, pkgs, ... }:

{
  imports = [
    ./packages
    ./xsession
    ./services
    ./programs
  ];

  home = {
    sessionVariables = {
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
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };
    theme = {
      name = "Adapta";
      package = pkgs.adapta-gtk-theme;
    };
    font = {
      name = "Ubuntu Regular 9.6";
      package = pkgs.ubuntu_font_family;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  programs = {
    home-manager.enable = true;
    home-manager.path = https://github.com/rycee/home-manager/archive/master.tar.gz;
  };

  fonts.fontconfig.enable = true;
}
