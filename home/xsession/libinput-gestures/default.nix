{ pkgs, ... }:

{
  home.packages = [ pkgs.libinput-gestures ];

  xdg.configFile."libinput-gestures.conf".text = ''
    ############################################
    # SWIPE GESTURES:
    ############################################

    # Move to next workspace
    gesture swipe left   _internal ws_up

    # Move to prev workspace
    gesture swipe right  _internal ws_down

    # Jump to next open browser tab
    gesture swipe up    xdotool key control+Tab

    # Jump to previous open browser tab
    gesture swipe down  xdotool key control+shift+Tab
  '';
}
