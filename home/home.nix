{ lib, pkgs, config, options, ... }:

with config.lib; {
  imports = import <imports> {
    inherit lib;
    dir = ./.;
  };

  home = {
    packages = [ pkgs.generation-diff ];

    sessionVariables = {
      PATH = "$HOME/.yarn/bin/:$PATH";
      EDITOR = packages.editor.name;
      PAGER = "most";
      USE_NIX2_COMMAND = 1;
      XDG_CURRENT_DESKTOP = "Gnome";
      NIX_PATH = ''
        nixpkgs="$(nix eval --raw '(import /etc/nixos/nix/sources.nix).nixpkgs.outPath')"'';
    };

    keyboard = {
      layout = "us,ru";
      options = [ "grp:caps_toggle" ];
    };
  };

  manual.manpages.enable = true;

  nixpkgs.config = {
    packageOverrides = lib.attrsets.optionalAttrs
      (builtins.length (config.programs.firefox.extensions) != 0)
      (pkgs: { nur = import sources.NUR { inherit pkgs; }; });

    allowUnfreePredicate = pkg:
      let
        name = if pkg ? "pname" then
          pkg.pname
        else if pkg ? "name" then
          (builtins.parseDrvName pkg.name).name
        else
          throw "Cannot figure out name of: ${pkg}";
      in builtins.elem name [ "typora" "slack" "vscode" ];
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
