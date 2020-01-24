{ lib, pkgs, ... }:

let
  gtkFont = (import ./themes { inherit pkgs; }).fonts.gtk;
in
{
  imports = [
    ./packages
    ./xsession
    ./services
    ./programs
  ];

  home = {
    sessionVariables = {
      PATH = "$HOME/.yarn/bin/:$PATH";
      EDITOR = "atom";
      PAGER = "most";
      USE_NIX2_COMMAND = 1;
    };
    keyboard = {
      layout = "us,ru";
      options = [ "grp:caps_toggle" ];
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
      name = "${gtkFont.name} ${gtkFont.size}";
      package = gtkFont.package;
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
