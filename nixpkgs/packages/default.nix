{ pkgs, ...}:

let
  python-packages = python-packages: with python-packages; [
    virtualenv
    pip
    pytorch
    torchvision
  ];

  python = pkgs.python3.withPackages python-packages;

  python2-packages = python-packages: with python-packages; [ pip ];

  python2 = pkgs.python2.withPackages python2-packages;

  haskell-packages = haskellPackages: with haskellPackages; [
    tidal
    happy
    alex
    unordered-containers
  ];

  haskell = pkgs.ghc.withPackages haskell-packages;

  speechd-pulse = pkgs.speechd.override { withPulse = true; };

in with pkgs; {
  home.packages =
    [
      git
      gitAndTools.diff-so-fancy

      # editors
      atom

      # languages related
      /* c++ */
      llvmPackages.clang-unwrapped
      (lowPrio gcc)
      gdb
      cmake
      valgrind
      /* java */
      openjdk11
      maven
      /* others */
      kotlin
      haskell
      python
      python2

      # docker
      docker
      docker_compose

      # utility packages
      htop     # interactive process viewer
      gnumake  # control the generation of non-source files from sources
      binutils # tools for manipulating binaries (linker, assembler, etc.)

      # filesystem utility packages
      autojump # rip cd
      exa      # rip ls
      ripgrep  # rip grep
      lf       # terminal file manager
      file     # determine file type
      most     # page text file
      fd       # find
      fzf      # a command-line fuzzy finder
      jmtpfs   # a FUSE filesystem for MTP devices like Android phones
      wget     # download

      # terminal helpful
      tldr     # a collection of simplified and community-driven man pages
      psmisc   # small useful utilities (such as fuser, killall and pstree)
      man      # an interface to the on-line reference manuals

      # messaging
      tdesktop

      # browsing
      firefox

      # archive management
      atool   # archive command line helper
      zip     # package and compress (archive) files
      unzip   # zip format extraction
      unrar   # utility for rar archives

      # graphics environment related
      gnome3.dconf         # fixes "failed to commit changes to dconf" issues
      unclutter            # remove idle cursor image from screen
      networkmanagerapplet # network manager applet
      inotify-tools
      gnomeExtensions.dash-to-panel

      # media
      google-play-music-desktop-player
      mpv                     # a media player
      pulseeffects            # limiter, compressor, reverberation, equalizer and auto volume effects
      playerctl               # controlling media players
      pavucontrol             # PulseAudio Volume Control
      libinput-gestures       # gesture mapper
      speechd-pulse

      # spell checkers
      hunspell
      hunspellDicts.en-us
      aspellDicts.en
      aspellDicts.en-computers
      aspellDicts.en-science
      aspellDicts.ru

      # fonts
      hasklig
      hack-font
      ubuntu_font_family

      # other
      blueman                 # bluetooth
      nox                     # tools to make nix nicer to use
      libreoffice-unwrapped   # office
      shared-mime-info        # a database of common MIME types
      gnutls                  # the GNU Transport Layer Security Library
      gnupg                   # the GNU Privacy Guard suite of programs
    ];
}
