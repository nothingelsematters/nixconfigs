{ pkgs, ... }:

with pkgs; {
  home.packages = [
    # messaging
    tdesktop

    # document related
    libreoffice-fresh # doc, excel, presentation
    evince            # pdf
    feh               # images

    # media
    spotify
    mpv          # a media player
    pulseeffects # limiter, compressor, reverberation, equalizer and auto volume effects
    playerctl    # controlling media players
    pavucontrol  # PulseAudio Volume Control
    (speechd.override { withPulse = true; })

    # spell checkers
    hunspell
    hunspellDicts.en-us
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    aspellDicts.ru

    # other
    inotify-tools
    shared-mime-info
    jmtpfs           # a FUSE filesystem for MTP devices like Android phones
    blueman          # bluetooth
    gnutls           # the GNU Transport Layer Security Library
    gnupg            # the GNU Privacy Guard suite of programs
    gnome3.dconf     # FIXING bugs, wtf, idk
  ];
}
