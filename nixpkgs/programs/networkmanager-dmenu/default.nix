{ config, pkgs, ... }:

{
  home.packages = [ pkgs.networkmanager_dmenu ];
  home.file.".config/networkmanager-dmenu/config.ini".text =
    ''
    [dmenu]
    dmenu_command = rofi -dmenu -no-show-icons -theme .config/rofi/networkmenu.rasi

    [editor]
    terminal = alacritty
    gui_if_available = True
    '';
}
