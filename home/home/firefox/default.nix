arg@{ config, pkgs, inputs, ... }:

with config.lib;
with builtins;
let
  mkCss = let
    valuef = path: value:
      "--${(concatStringsSep "-" ([ "theme" ] ++ path))}: ${toString value};";

    recurse = func: path:
      mapAttrs (name: value:
        (if isAttrs value then (recurse func) else valuef) (path ++ [ name ])
        value);

    collect = attrs:
      if isAttrs attrs then concatMap collect (attrValues attrs) else [ attrs ];
  in attrs: "{${concatStringsSep "\n" (collect (recurse valuef [ ] attrs))}}";

  themeCss = ''
    :root ${mkCss theme.colors}
  '';
in {
  home.file.".mozilla/firefox/default/chrome/userContent.css".text = themeCss
    + readFile ./userContent.css;

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
            ${readFile ./overrides.css}
          '';
        };
      };
    };
  };
}
