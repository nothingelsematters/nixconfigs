{ config, pkgs, ... }:

with config.lib;
let
  appsmenu = "rofi/appsmenu.rasi";

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
  xdg.configFile.${appsmenu}.text = makeTheme ./appsmenu.rasi;

  lib.packages.launcher = {
    name = "rofi";
    cmd = "rofi -show";
    package = pkgs.rofi;
  };

  programs.rofi = {
    enable = true;
    lines = 8;
    cycle = true;
    fullscreen = true;
    scrollbar = false;
    theme = config.xdg.configHome + ("/" + appsmenu);
    terminal = config.lib.packages.terminal.name;

    font = "${theme.fonts.notification} 10";

    extraConfig = ''
      rofi.modi:                drun
      rofi.matching:            fuzzy
      rofi.drun-match-fields:   name
      rofi.drun-display-format: {icon}
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
