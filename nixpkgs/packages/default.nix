{ pkgs, ... }:

with pkgs; {
  home.packages = [
    git gitAndTools.diff-so-fancy
    docker docker_compose

    # filesystem utility packages
    exa     # rip ls
    ripgrep # rip grep
    lf      # terminal file manager
    file    # determine file type
    most    # page text file
    fd      # find
    jmtpfs  # a FUSE filesystem for MTP devices like Android phones
    wget    # download

    # utility packages
    gnumake  # control the generation of non-source files from sources
    binutils # tools for manipulating binaries (linker, assembler, etc.)
    xclip    # clipboard manipulations

    # editor
    typora

    # temp
    jetbrains-mono

    # languages related
    /* c++ */        gcc gdb cmake valgrind
    /* kotlin */     kotlin
    /* java */       jdk12 maven antlr4
    /* haskell */    (ghc.withPackages (ps: with ps; [ stack unordered-containers /* stylish-haskell */ ]))
    /* python */     (python3.withPackages (ps: with ps; [ virtualenv pip ]))
    /* python2 */    (python2.withPackages (ps: with ps; [ pip ]))
    /* javascript */ nodejs yarn

    # terminal helpful
    tldr   # a collection of simplified and community-driven man pages
    psmisc # small useful utilities (such as fuser, killall and pstree)
    man    # an interface to the on-line reference manuals

    # messaging
    tdesktop
    slack-dark

    # document related
    libreoffice-unwrapped
    evince
    feh

    # archive management
    atool # archive command line helper
    zip   # package and compress (archive) files
    unzip # zip format extraction
    unrar # utility for rar archives

    # graphics environment related
    inotify-tools # notifier

    # media
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

    # NixOS house keeping
    nox    # tools to make nix nicer to use
    vulnix # NixOS vulnerability scanner
    nixfmt # nix formatter

    # other
    blueman          # bluetooth
    shared-mime-info # a database of common MIME types
    gnutls           # the GNU Transport Layer Security Library
    gnupg            # the GNU Privacy Guard suite of programs
    gnome3.dconf     # FIXING bugs, wtf, idk
  ];
}
