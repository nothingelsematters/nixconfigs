{ config, pkgs, ... }:

{
  home.packages = [ pkgs.networkmanager_dmenu ];
  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi -dmenu -no-show-icons -no-fullscreen -columns 1 -theme .config/rofi/networkmenu.rasi

    [editor]
    terminal = alacritty
    gui_if_available = True
  '';
}
