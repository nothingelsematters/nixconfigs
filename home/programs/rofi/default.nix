{ config, pkgs, lib, ... }:

# TODO wait for release...

let
  theme = import ../../theme { inherit pkgs lib; };
  vars = import ../../lib { inherit pkgs; };
  appsmenu = ".config/rofi/appsmenu.rasi";
  networkmenu = ".config/rofi/networkmenu.rasi";

  makeTheme = fileName: ''
    * {
      background:       ${theme.colors.background.secondary};
      accent:           ${theme.colors.text.secondary};
      foreground:       ${theme.colors.text.primary};
      text-font:        "${theme.fonts.notification} 10";
      text-font-mono:   "${theme.fonts.mono.name} 10";
    }

    ${builtins.readFile fileName}
  '';

in {
  home.file.${appsmenu}.text = makeTheme ./appsmenu.rasi;
  home.file.${networkmenu}.text = makeTheme ./networkmenu.rasi;

  programs.rofi = {
    enable = true;
    lines = 8;
    cycle = true;
    fullscreen = false;
    scrollbar = false;
    theme = appsmenu;
    terminal = vars.terminal.name;

    font = "${theme.fonts.notification} 10";
    extraConfig = ''
      rofi.modi:                drun
      rofi.matching:            fuzzy
      rofi.drun-match-fields:   name
      rofi.drun-display-format: {name}
      rofi.kb-row-select:       ctrl+shift+space
      rofi.kb-cancel:           Menu,Escape,alt+r
      rofi.show-icons:          true
      rofi.kb-row-tab:          shift+Tab
      rofi.icon-theme:          ${theme.icons.name}
      rofi.disable-history:     false
      rofi.display-drun:        apps
      rofi.columns:             2
    '';
  };
}
