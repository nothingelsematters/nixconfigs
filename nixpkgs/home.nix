{ lib, pkgs, ... }:

let theme = import ./theme { inherit pkgs; };
in {
  imports = [ ./packages ./xsession ./services ./programs ];

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
    iconTheme = theme.icons;
    theme = theme.gtk;
    font = theme.fonts.gtk;
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
  };

  programs = {
    home-manager = {
      enable = true;
      path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
    };
  };

  fonts.fontconfig.enable = true;
}
