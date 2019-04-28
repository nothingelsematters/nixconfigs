pkgs:
let
    speechd-pulse = pkgs.speechd.override {
    	withPulse = true;
    };
in
  with pkgs;
  [
    # Utility packages
    fzf      # a command-line fuzzy finder
    htop     # interactive process viewer
    gnumake  # control the generation of non-source files from sources
    binutils # tools for manipulating binaries (linker, assembler, etc.)

    # Filesystem utility packages
    autojump # rip cd
    exa      # rip ls
    bat      # rip cat
    ripgrep  # rip grep
    lf       # terminal file manager
    most     # page text file
    fd       # find
    wget     # download
    jmtpfs   # a FUSE filesystem for MTP devices like Android phones

    # Terminal helpful
    tldr     # a collection of simplified and community-driven man pages
    psmisc   # small useful utilities (such as fuser, killall and pstree)

    # Messaging
    tdesktop

    # Browsing
    firefox

    # Archive management
    atool   # archive command line helper
    zip     # package and compress (archive) files
    unzip   # zip format extraction
    unrar   # utility for rar archives

    # Graphics Environment Related
    gnome3.dconf         # fixes "failed to commit changes to dconf" issues
    unclutter            # remove idle cursor image from screen
    networkmanagerapplet # network manager applet
    inotify-tools
    arc-theme

    # Media
    google-play-music-desktop-player
    mpv                     # a media player
    pulseeffects            # limiter, compressor, reverberation, equalizer and auto volume effects
    playerctl               # controlling media players
    pavucontrol             # PulseAudio Volume Control
    speechd-pulse

    # Spell Checkers
    hunspell
    hunspellDicts.en-us
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    aspellDicts.ru

    # Other
    blueman                 # bluetooth
    file                    # determine file type
    nox                     # tools to make nix nicer to use
    libreoffice-unwrapped   # office
    shared-mime-info        # a database of common MIME types
    gnutls                  # the GNU Transport Layer Security Library
    gnupg                   # the GNU Privacy Guard suite of programs
    telnet

    # Could be useful someday
    # texlive.combined.scheme-full
    # gparted
    #
    # Image editing
    # imagemagick
    # pinta
    # krita
    # gimp
  ]
