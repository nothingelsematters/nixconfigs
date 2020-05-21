{ lib, pkgs, config, ... }:

let
  getName = drv:
    if builtins.hasAttr "pname" drv then
      drv.pname
    else if builtins.hasAttr "name" drv then
      (builtins.parseDrvName drv.name).name
    else
      throw "Cannot figure out name of: ${drv}";
in with config.lib; {
  imports = import lib/imports.nix lib ./.;

  home = {
    sessionVariables = {
      PATH = "$HOME/.yarn/bin/:$PATH";
      EDITOR = "code";
      PAGER = "most";
      USE_NIX2_COMMAND = 1;
      XDG_CURRENT_DESKTOP = "Gnome";
    };

    keyboard = {
      layout = "us,ru";
      options = [ "grp:caps_toggle" ];
    };
  };

  manual.manpages.enable = true;

  nixpkgs.config = {
    packageOverrides = pkgs: { nur = import sources.NUR { inherit pkgs; }; };
    allowUnfreePredicate = with pkgs;
      pkg:
      builtins.elem (getName pkg) [ "typora" "slack" "vscode" "unrar" ];
  };

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
