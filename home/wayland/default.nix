{ config, lib, ... }:

let
  desktop = x: [ (x + ".desktop") ];
  browser = desktop "firefox";
in {
  imports = import ../lib/imports.nix lib ./.;

  xdg.mimeApps.defaultApplications = {
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
    "text/plain" = desktop "code";
  };
}
