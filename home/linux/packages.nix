{ pkgs, ... }:

with pkgs; {
  home.packages = [
    # messaging
    tdesktop

    # media
    spotify
    mpv
    pulseeffects-pw
    playerctl
    pavucontrol

    # document related
    libreoffice-fresh
    evince
    feh

    # other
    psmisc # fuser, killall and pstree...
    inotify-tools
    blueman
    jmtpfs # a FUSE filesystem for MTP devices like Android phones
    gnome3.dconf # FIXING bugs, wtf, idk
  ];
}
