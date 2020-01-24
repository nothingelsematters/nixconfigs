{ config, pkgs, ... }:

let
  theme = import ../../themes { inherit pkgs; };

  readSet = with builtins; file:
    let
      matcher = match "[[:space:]]*\"(.*)\"[[:space:]]*=[[:space:]]*(.*);.*";
      lines = filter isString (split "\n" (readFile file));
      settings = filter (x: isNull x != true && length x == 2) (map matcher lines);
      mkSet = list: {
        name = elemAt list 0;
        value = fromJSON (elemAt list 1);
      };
    in
      listToAttrs (map mkSet settings);
in
{
  programs.firefox = {
    enable = true;
    profiles = {

      default = {
        id = 0;
        isDefault = true;

        userChrome = ''
        @import "${pkgs.fetchFromGitHub {
          owner = "muckSponge";
          repo = "materialFox";
          rev = "f3d6ed009ef8e06bc91c799dc69471d0742f17f6";
          sha256 = "0cc50c3q7nwcq3kag2rafchqndnnhpl6y4v7m62aiidnl4h5jhjw";
        } + "/chrome/userChrome.css"}"
        '';

        settings = readSet ./settings.conf // {
          "font.name.monospace.x-western" = theme.fonts.mono;
          "browser.uiCustomization.state" = builtins.readFile ./uiCustomization.json;
        };
      };
    };
  };
}
