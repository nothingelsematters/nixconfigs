{ lib, pkgs, ... }:

let
  theme = import ./theme { inherit pkgs lib; };
  sources = import ../nix/sources.nix;
in {
  imports = [ ./development ./packages ./wayland ./services ./programs ];

  home = {
    sessionVariables = {
      PATH = "$HOME/.yarn/bin/:$PATH";
      EDITOR = "atom";
      PAGER = "most";
      USE_NIX2_COMMAND = 1;
      XDG_CURRENT_DESKTOP = "Gnome"; # telegram shitty file-piker fix
    };

    keyboard = {
      layout = "us,ru";
      options = [ "grp:caps_toggle" ];
    };
  };

  manual.manpages.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;

    packageOverrides = pkgs: { nur = import sources.NUR { inherit pkgs; }; };
  };
  _module.args.pkgs = pkgs.lib.mkForce pkgs;

  gtk = {
    enable = true;
    iconTheme = theme.icons;
    theme = theme.gtk;
    font = theme.fonts.gtk;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = theme.isDark;
  };

  programs.home-manager = {
    enable = true;
    path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
  };
}
