arg@{ config, pkgs, lib, ... }:

with config.lib;
let
  # addons = import ./addons/default.nix {
  #   buildFirefoxXpiAddon =
  #     pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon;
  #   fetchurl = pkgs.fetchurl;
  #   stdenv = pkgs.stdenv;
  # };

  themeCss = ''
    :root ${theme.utils.mkCss theme.colors}
  '';
in {
  lib.packages.browser = {
    name = "firefox";
    package = pkgs.firefox;
  };

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
