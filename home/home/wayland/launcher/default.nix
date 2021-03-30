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

    extraConfig = {
      show-icons = true;
      drun-display-format = "{name}";
      threads = 0;
      matching = "fuzzy";
      disable-history = false;
      modi = "drun";
      window-thumbnail = true;
      drun-match-fields = "name";
      kb-row-select = "ctrl+shift+space";
      kb-cancel = "Menu,Escape,alt+r";
      kb-row-tab = "shift+Tab";
      icon-theme = theme.icons.name;
      display-drun = "apps";
      columns = 8;
    };
  };
}
