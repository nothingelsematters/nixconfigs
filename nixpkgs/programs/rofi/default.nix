{ config, pkgs, ...}:

let
  theme = import ../../theme { inherit pkgs; };
  appsmenu = ".config/rofi/appsmenu.rasi";
  networkmenu = ".config/rofi/networkmenu.rasi";

  makeTheme = with builtins;
    let
      lines = x: filter isString (split "\n" (readFile x));

      importLine = "@import";
      isImport = x: substring 0 (stringLength importLine) x == importLine;
      imports = x: concatLists (map (match (importLine + " (.*);")) (filter isImport (lines x)));
      withoutImports = x: concatStringsSep "\n" (filter (y: !(isImport y)) (lines x));

      patchImports = file: ''
        ${concatStringsSep "\n" (map (x: patchImports (dirOf file + ("/" + x))) (imports file))}
        ${withoutImports file}
        '';

    in fileName:
      ''
      * {
        background:       ${theme.colors.background.secondary};
        accent:           ${theme.colors.text.secondary};
        foreground-list:  ${theme.colors.text.primary};
        text-font:        "${theme.fonts.notification} 10";
        text-font-mono:   "${theme.fonts.mono} 10";
      }

      ${patchImports fileName}
      '';
in

{
  home.file."${appsmenu}".text = makeTheme ./appsmenu.rasi;
  home.file."${networkmenu}".text = makeTheme ./networkmenu.rasi;

  programs.rofi = {
    enable = true;
    lines = 7;
    cycle = true;
    fullscreen = true;
    scrollbar = false;
    theme = appsmenu;
    terminal = "alacritty";

    font = "${theme.fonts.notification} 10";
    extraConfig =
      ''
      rofi.modi:                drun
      rofi.matching:            fuzzy
      rofi.drun-match-fields:   name
      rofi.drun-display-format: {name}
      rofi.kb-row-select:       ctrl+shift+space
      rofi.kb-cancel:           Menu,Escape,alt+r
      rofi.show-icons:          true
      rofi.kb-row-tab:          shift+Tab
      rofi.icon-theme:          Paper
      rofi.disable-history:     false
      rofi.display-drun:        apps
      rofi.columns:             2
      '';
  };
}
