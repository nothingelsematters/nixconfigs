{ config, pkgs, ... }:

let
  theme = import ../../theme { inherit pkgs; };
  mkCss = import ../../theme/lib/mkCss.nix;
  withTheme = x: ":root ${mkCss theme.colors}\n" + x;

  lines = with builtins; file: filter isString (split "\n" (readFile file));
  readSet = with builtins; file:
    let
      matcher = match "[[:space:]]*\"(.*)\"[[:space:]]*=[[:space:]]*(.*);.*";
      settings = filter (x: isNull x != true && length x == 2) (map matcher (lines file));
      mkSet = list: {
        name = elemAt list 0;
        value = fromJSON (elemAt list 1);
      };
    in
      listToAttrs (map mkSet settings);

  withImports = with builtins; let
    patchImports = file:
      let
        importLine = "@import";
        isImport = x: substring 0 (stringLength importLine) x == importLine;
        imports = x: concatLists (map (match (importLine + " \"(.*)\";")) (filter isImport (lines x)));
        importing = x: withImports (dirOf file + ("/" + x));
      in concatStringsSep "\n" (map importing (imports file));

    withUrls = file:
      let
        fileStr = readFile file;
        urls = concatLists (filter isList (split "url\\(([^\\.\\)]+\\.svg)\\)" fileStr));
        replacement = map (x: toString (dirOf file + ("/" + x))) urls;
      in replaceStrings urls replacement fileStr;

  in file: withUrls file + "\n" + patchImports file;

  patchedUserChrome = withTheme
    ''
    ${withImports (
      pkgs.fetchFromGitHub {
        owner = "muckSponge";
        repo = "materialFox";
        rev = "f3d6ed009ef8e06bc91c799dc69471d0742f17f6";
        sha256 = "0cc50c3q7nwcq3kag2rafchqndnnhpl6y4v7m62aiidnl4h5jhjw";
      } + "/chrome/userChrome.css")}
    ${builtins.readFile ./overrides.css}
    '';
in
{
  home.file.".mozilla/firefox/default/chrome/userContent.css".text = withTheme (builtins.readFile ./userContent.css);

  programs.firefox = {
    enable = true;
    profiles = {

      default = {
        id = 0;
        isDefault = true;
        userChrome = patchedUserChrome;
        settings = readSet ./settings.conf // {
          "font.name.monospace.x-western" = theme.fonts.mono;
          "browser.uiCustomization.state" = builtins.readFile ./uiCustomization.json;
          "ui.systemUsesDarkTheme" = if theme.isDark then 1 else 0;
        };
      };
    };
  };
}
