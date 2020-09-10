arg@{ config, pkgs, lib, ... }:

with config.lib;
let
  themeCss = ''
    :root ${theme.utils.mkCss theme.colors}
  '';
in {
  lib.packages.browser = {
    name = "firefox";
    package = pkgs.firefox;
  };

  home.file.".mozilla/firefox/default/chrome/userContent.css".text = themeCss
    + builtins.readFile ./userContent.css;

  programs.firefox = {
    enable = true;
    profiles = {

      default = {
        id = 0;
        isDefault = true;
        settings = import ./settings.nix arg;
        userChrome = ''
          @import "${pkgs.materialFox + /chrome/userChrome.css}";
          ${themeCss}
          ${builtins.readFile ./overrides.css}
        '';
      };
    };
  };
}
