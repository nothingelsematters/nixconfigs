{...}:

{
  xdg.configFile."mimeapps.list".text = ''
    [Default Applications]
    # Doc viewer
    application/pdf=org.pwmt.zathura.desktop;
    image/vnd.djvu=org.pwmt.zathura.desktop;
    # Browser
    application/x-extension-htm=firefox.desktop;
    application/x-extension-html=firefox.desktop;
    application/x-extension-shtml=firefox.desktop;
    application/xhtml+xml=firefox.desktop;
    application/x-extension-xhtml=firefox.desktop;
    application/x-extension-xht=firefox.desktop;
    x-scheme-handler/http=firefox.desktop;
    x-scheme-handler/https=firefox.desktop;
    # Pic viewer
    image/png=feh.desktop;
    image/jpeg=feh.desktop;
    # Text viewer
    text/plain=atom.desktop;
    '';
}
