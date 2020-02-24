{ config, pkgs, lib, ... }:

let
  theme = import ../../theme { inherit pkgs lib; };
  mkCss = import ../../theme/lib/mkCss.nix;
  settings = import ./settings.nix { inherit config theme; };
  themeCss = ''
    :root ${mkCss theme.colors}
  '';

  materialFox = pkgs.fetchFromGitHub {
    owner = "muckSponge";
    repo = "materialFox";
    rev = "f3d6ed009ef8e06bc91c799dc69471d0742f17f6";
    sha256 = "0cc50c3q7nwcq3kag2rafchqndnnhpl6y4v7m62aiidnl4h5jhjw";
  } + "/chrome/userChrome.css";

  patchedUserChrome = ''
    @import "${materialFox}";
    ${themeCss}
    ${builtins.readFile ./overrides.css}
  '';
in {
  home.file.".mozilla/firefox/default/chrome/userContent.css".text = themeCss
    + builtins.readFile ./userContent.css;

  programs.firefox = {
    enable = true;
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
