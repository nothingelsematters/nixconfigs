{ pkgs, ... }:

with pkgs; {
  home.packages = [
    # filesystem utility packages
    exa     # rip ls
    ripgrep # rip grep
    fd      # rip find
    lf      # terminal file manager
    file    # determine file type
    jmtpfs  # a FUSE filesystem for MTP devices like Android phones
    wget    # download

    # utility packages
    gnumake  # control the generation of non-source files from sources
    binutils # tools for manipulating binaries (linker, assembler, etc)
    jq       # processing JSON inputs

    # terminal helpful
    man    # on-line reference manuals
    tldr   # simplified man pages
    psmisc # fuser, killall and pstree...

    # messaging
    tdesktop

    # document related
    libreoffice-fresh # doc, excel, presentation
    evince            # pdf
    feh               # images

    # archive management
    atool # archive command line helper
    zip   # package and compress archive files
    unzip # zip format extraction

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
    blueman          # bluetooth
    gnutls           # the GNU Transport Layer Security Library
    gnupg            # the GNU Privacy Guard suite of programs
    gnome3.dconf     # FIXING bugs, wtf, idk
  ];
}
