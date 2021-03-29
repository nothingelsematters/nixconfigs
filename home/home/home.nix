{ lib, pkgs, config, overlays, ... }:

with config.lib; {
  imports = [ ../common ] ++ import ../../lib/imports.nix {
    inherit lib;
    dir = ./.;
    recursive = true;
    includeFiles = true;
    exclude = [ "/default.nix" "/home.nix" ];
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

    extraProfileCommands = ''
      if [[ -d "$out/share/applications" ]] ; then
        ${pkgs.desktop-file-utils}/bin/update-desktop-database $out/share/applications
      fi
    '';
  };

  gtk = {
    enable = true;
    iconTheme = theme.icons;
    theme = theme.gtk;
    font = theme.fonts.gtk;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = theme.isDark;
  };

  xdg.mimeApps.defaultApplications = with packages;
    let
      desktop = x: [ (x + ".desktop") ];
      browser = desktop browser.name;
      evince = desktop "evince";
      feh = desktop "feh";
    in {
      # Doc viewer
      "application/pdf" = evince;
      "image/vnd.djvu" = evince;
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
      "image/png" = feh;
      "image/jpeg" = feh;
      # Text viewer
      "text/plain" = desktop editor.name;
    };
}
