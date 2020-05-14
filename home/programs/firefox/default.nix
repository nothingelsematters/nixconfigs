arg@{ config, pkgs, lib, ... }:

with config.lib;
let
  settings = import ./settings.nix arg;
  /* addons = import ./addons/default.nix {
       buildFirefoxXpiAddon =
         pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon;
       fetchurl = pkgs.fetchurl;
       stdenv = pkgs.stdenv;
     };
  */

  themeCss = ''
    :root ${theme.utils.mkCss theme.colors}
  '';

  materialFox = sources.materialFox + /chrome/userChrome.css;
  patchedUserChrome = ''
    @import "${materialFox}";
    ${themeCss}
    ${builtins.readFile ./overrides.css}
  '';
in {
  home = {
    # packages = [ pkgs.nur.repos.rycee.firefox-addons-generator ];
    file.".mozilla/firefox/default/chrome/userContent.css".text = themeCss
      + builtins.readFile ./userContent.css;
  };

  programs.firefox = {
    enable = true;
    # extensions = builtins.attrValues addons;
    profiles = {

      default = {
        id = 0;
        isDefault = true;
        userChrome = patchedUserChrome;
        settings = settings;
      };
    };
  };
}
