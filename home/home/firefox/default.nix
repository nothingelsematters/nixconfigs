arg@{ config, pkgs, inputs, ... }:

with config.lib;
let
  themeCss = ''
    :root ${theme.utils.mkCss theme.colors}
  '';
in {
  home.file.".mozilla/firefox/default/chrome/userContent.css".text = themeCss
    + builtins.readFile ./userContent.css;

  programs = {
    browserpass = {
      enable = true;
      browsers = [ "firefox" ];
    };

    firefox = {
      enable = true;
      profiles = {

        default = {
          id = 0;
          isDefault = true;
          settings = import ./settings.nix arg;
          # TODO it is broken
          userChrome = ''
            @import "${inputs.materialFox + /chrome/userChrome.css}";
            ${themeCss}
            ${builtins.readFile ./overrides.css}
          '';
        };
      };
    };
  };
}
