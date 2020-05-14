{ pkgs, ... }:

with pkgs; {
  home.packages = [
    ## filesystem utility packages
    exa     # rip ls
    ripgrep # rip grep
    fd      # rip find
    lf      # terminal file manager
    file    # determine file type
    most    # page text file
    jmtpfs  # a FUSE filesystem for MTP devices like Android phones
    wget    # download

    ## utility packages
    gnumake  # control the generation of non-source files from sources
    binutils # tools for manipulating binaries (linker, assembler, etc)
    xclip    # clipboard manipulations
    jq       # processing JSON inputs

    ## terminal helpful
    tldr   # simplified man pages
    psmisc # fuser, killall and pstree...
    man    # on-line reference manuals

    ## messaging
    tdesktop
    slack-dark

    ## document related
    libreoffice
    evince
    feh

    ## archive management
    atool # archive command line helper
    zip   # package and compress archive files
    unzip # zip format extraction
    unrar # utility for rar archives

    ## media
    mpv          # a media player
    pulseeffects # limiter, compressor, reverberation, equalizer and auto volume effects
    playerctl    # controlling media players
    pavucontrol  # PulseAudio Volume Control
    (speechd.override { withPulse = true; })

    ## NixOS house keeping
    nox    # tools to make nix nicer to use
    vulnix # NixOS vulnerability scanner

    ## spell checkers
    hunspell
    hunspellDicts.en-us
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    aspellDicts.ru

    ## other
    inotify-tools
    shared-mime-info
    blueman          # bluetooth
    gnutls           # the GNU Transport Layer Security Library
    gnupg            # the GNU Privacy Guard suite of programs
    gnome3.dconf     # FIXING bugs, wtf, idk
  ];
}
