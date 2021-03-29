{ config, pkgs, ... }:

with config.lib;
let appsmenu = "rofi/appsmenu.rasi";
in {
  xdg.configFile.${appsmenu}.text = ''
    * {
      foreground: ${theme.colors.text.primary};
      text-font:  "${theme.fonts.notification} 10";
    }

    ${builtins.readFile ./appsmenu.rasi}
  '';

  lib.packages.launcher = {
    name = "rofi";
    cmd = "rofi -show";
    package = config.programs.rofi.package;
  };

  programs.rofi = {
    enable = true;
    lines = 8;
    cycle = false;
    fullscreen = true;
    scrollbar = false;
    theme = config.xdg.configHome + ("/" + appsmenu);
    terminal = config.lib.packages.terminal.name;

    font = "${theme.fonts.notification} 10";

    extraConfig = ''
      rofi.font:                ${theme.fonts.notification} 10
      rofi.show-icons:          true
      rofi.drun-display-format: {name}
      rofi.threads:             0
      rofi.matching:            fuzzy
      rofi.disable-history:     false
      rofi.modi:                drun
      rofi.window-thumbnail:    true
      rofi.drun-match-fields:   name
      rofi.kb-row-select:       ctrl+shift+space
      rofi.kb-cancel:           Menu,Escape,alt+r
      rofi.kb-row-tab:          shift+Tab
      rofi.icon-theme:          ${theme.icons.name}
      rofi.display-drun:        apps
      rofi.columns:             8
    '';
  };
}
