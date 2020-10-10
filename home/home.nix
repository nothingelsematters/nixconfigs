{ lib, pkgs, config, options, overlays, ... }:

with config.lib; {
  imports = import lib/imports.nix {
    inherit lib;
    dir = ./.;
    recursive = true;
  };

  home = {
    sessionVariables = {
      PATH = "$HOME/.yarn/bin/:$PATH";
      EDITOR = packages.editor.name;
      PAGER = "most";
      USE_NIX2_COMMAND = 1;
      XDG_CURRENT_DESKTOP = "Gnome";
      QT_QPA_PLATFORM = "wayland";
      NIX_PATH = "nixpkgs=${pkgs.nixpkgs.outPath}";
    };

    keyboard = {
      layout = "us,ru";
      options = [ "grp:caps_toggle" ];
    };
  };

  manual.manpages.enable = true;

  nixpkgs = {
    inherit overlays;
    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.strings.getName pkg) [
        "typora"
        "slack"
        "vscode"
        "spotify"
        "spotify-unwrapped"
      ];
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

  xdg.mimeApps.defaultApplications = with packages;
    let
      desktop = x: [ (x + ".desktop") ];
      browser = desktop browser.name;
    in {
      # Doc viewer
      "application/pdf" = desktop "evince";
      "image/vnd.djvu" = desktop "evince";
      # Browser
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/xhtml+xml" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-extension-xht" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      # Pic viewer
      "image/png" = desktop "feh";
      "image/jpeg" = desktop "feh";
      # Text viewer
      "text/plain" = desktop editor.name;
    };
}
