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

    ## editor
    typora

    ## languages related
    # c++
    gcc
    gdb
    cmake
    valgrind

    # kotlin
    kotlin

    # java
    jdk12
    maven
    antlr4

    # haskell
    (ghc.withPackages (ps:
      with ps; [
        # usefull
        unordered-containers

        # building
        stack
        cabal2nix
        stylish-haskell
        # TODO my heart is marked as broken, refusing to evaluate:
        # stack2nix

        # testing
        hspec
        hedgehog
        tasty
        tasty-hedgehog
        tasty-hspec
      ]))

    # python
    (python3.withPackages (ps: with ps; [ virtualenv pip ]))

    # python2
    (python2.withPackages (ps: with ps; [ pip ]))

    # javascript
    nodejs
    yarn


    ## terminal helpful
    tldr   # simplified man pages
    psmisc # fuser, killall and pstree...
    man    # on-line reference manuals

    ## messaging
    # TODO shitty fonts, ui horrible af
    tdesktop
    slack-dark

    ## document related
    libreoffice-unwrapped
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
    nixfmt # nix formatter
    niv    # nix dependencies handler

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
