{
  home.file.".config/libinput-gestures.conf".text =
    ''
    # Configuration file for libinput-gestures

    ###############################################################################
    # SWIPE GESTURES:
    ###############################################################################

    # Move to next workspace (works for GNOME/KDE/etc on Wayland and Xorg)
    gesture swipe up	_internal ws_up

    # Move to prev workspace (works for GNOME/KDE/etc on Wayland and Xorg)
    gesture swipe down	_internal ws_down

    # Jump to next open browser tab
    gesture swipe left xdotool key control+Tab

    # Jump to previous open browser tab
    gesture swipe right xdotool key control+shift+Tab

    ###############################################################################
    # PINCH GESTURES:
    ###############################################################################

    # GNOME SHELL open/close overview (works for GNOME on Xorg only)
    gesture pinch in	xdotool key super+s
    gesture pinch out	xdotool key super+s
    '';
}
