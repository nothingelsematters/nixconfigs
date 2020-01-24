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
          rev = "92e66339d449561138f52bb193a66303d8bbb5ce";
          sha256 = "12ys44jv04jx1gyrscqry540w48qz8kdv8f01wrhc04qcg96l8b6";
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
